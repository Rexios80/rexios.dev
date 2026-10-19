import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:http/http.dart' as http;
import 'package:rexios_dev/data/models.dart';

const _pubApiRoot = 'https://pub.dev/api';

const _publishers = ['rexios.dev', 'vrchat.community', 'iodesignteam.com'];
const _featuredRepo = 'Rexios80/hds_overlay';
const _packageLimit = 10;
const _repoLimit = 5;
const _maxConcurrent = 8;

class PortfolioData {
  const PortfolioData({required this.hds, required this.repositories, required this.packages});

  final RepoInfo hds;
  final List<RepoInfo> repositories;
  final List<PackageInfo> packages;
}

PortfolioData? _cache;
DateTime? _cacheTime;

Future<PortfolioData> loadPortfolio() async {
  final cached = _cache;
  final cachedAt = _cacheTime;
  if (cached != null && cachedAt != null && DateTime.now().difference(cachedAt) < const Duration(minutes: 2)) {
    return cached;
  }

  final client = http.Client();
  try {
    final (hds, repositories, packages) = await (
      _fetchHds(client),
      _fetchOtherRepos(client),
      _fetchTopPackages(client),
    ).wait;
    final data = PortfolioData(hds: hds, repositories: repositories, packages: packages);
    _cache = data;
    _cacheTime = DateTime.now();
    return data;
  } finally {
    client.close();
  }
}

Future<dynamic> _getJson(http.Client client, Uri uri) async {
  final headers = {'User-Agent': 'rexios.dev', 'Accept': 'application/json'};
  if (uri.host == 'api.github.com') {
    final token = Platform.environment['GITHUB_TOKEN']?.trim();
    if (token != null && token.isNotEmpty) headers['Authorization'] = 'Bearer $token';
  }
  final response = await client.get(uri, headers: headers).timeout(const Duration(seconds: 20));
  if (response.statusCode != 200) {
    throw Exception('HTTP ${response.statusCode} for $uri');
  }
  return jsonDecode(response.body);
}

Map<String, dynamic> _asMap(Object? value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return value.cast<String, dynamic>();
  throw FormatException('Expected a JSON object');
}

Future<RepoInfo> _fetchHds(http.Client client) async {
  final json = _asMap(await _getJson(client, Uri.https('api.github.com', '/repos/$_featuredRepo')));
  return RepoInfo.fromGitHub(json);
}

Future<List<RepoInfo>> _fetchOtherRepos(http.Client client) async {
  final names = <String>[];
  for (var page = 1; page <= 10 && names.length < _repoLimit; page++) {
    final decoded = await _getJson(
      client,
      Uri.https('api.github.com', '/users/Rexios80/repos', {'per_page': '100', 'page': '$page'}),
    );
    if (decoded is! List || decoded.isEmpty) break;
    for (final item in decoded) {
      final json = _asMap(item);
      if (!_includeRepo(json)) continue;
      names.add(json['name'] as String);
      if (names.length == _repoLimit) break;
    }
    if (decoded.length < 100) break;
  }

  // The list endpoint omits subscribers_count, so watcher counts come from each repo.
  final detailed = await Future.wait(
    names.map((name) async {
      final json = _asMap(await _getJson(client, Uri.https('api.github.com', '/repos/Rexios80/$name')));
      return RepoInfo.fromGitHub(json);
    }),
  );
  detailed.sort((a, b) => b.stars.compareTo(a.stars));
  return detailed;
}

bool _includeRepo(Map<String, dynamic> json) {
  if (json['full_name'] == _featuredRepo) return false;
  if (json['fork'] == true || json['archived'] == true) return false;
  final description = json['description'] as String? ?? '';
  if (description.isEmpty || description.contains('rexios.dev:ignore')) return false;
  final homepage = json['homepage'] as String? ?? '';
  if (homepage.contains('pub.dev')) return false;
  return (json['name'] as String?)?.isNotEmpty ?? false;
}

class _Score {
  const _Score({required this.likes, required this.points, required this.downloads});

  final int likes;
  final int points;
  final int downloads;
}

Future<List<PackageInfo>> _fetchTopPackages(http.Client client) async {
  final names = <String>[];
  final seen = <String>{};
  for (final publisher in _publishers) {
    for (final name in await _publisherPackages(client, publisher)) {
      if (seen.add(name)) names.add(name);
    }
  }

  final scores = await _pool(_maxConcurrent, [
    for (final name in names) () => _fetchScore(client, name).timeout(const Duration(seconds: 10)),
  ]);

  final ranked = [for (var i = 0; i < names.length; i++) (name: names[i], score: scores[i])];
  ranked.sort((a, b) => b.score.downloads.compareTo(a.score.downloads));

  final starRequests = <String, Future<int>>{};
  final packages = await Future.wait([
    for (final entry in ranked.take(_packageLimit))
      _fetchPackage(client, entry.name, entry.score, starRequests).timeout(const Duration(seconds: 10)),
  ]);
  packages.sort((a, b) => b.downloads.compareTo(a.downloads));
  return packages;
}

Future<List<String>> _publisherPackages(http.Client client, String publisher) async {
  final names = <String>[];
  for (var page = 1; page <= 10; page++) {
    final json = _asMap(
      await _getJson(
        client,
        Uri.parse('$_pubApiRoot/search').replace(
          queryParameters: {'q': 'publisher:$publisher', 'page': '$page', 'sort': 'top'},
        ),
      ),
    );
    final packages = json['packages'];
    if (packages is! List || packages.isEmpty) break;
    for (final item in packages) {
      final name = _asMap(item)['package'];
      if (name is String && name.isNotEmpty) names.add(name);
    }
    if (json['next'] == null || packages.length < 10) break;
  }
  return names;
}

Future<_Score> _fetchScore(http.Client client, String name) async {
  final json = _asMap(await _getJson(client, Uri.parse('$_pubApiRoot/packages/$name/score')));
  final likes = json['likeCount'];
  final points = json['grantedPoints'];
  final downloads = json['downloadCount30Days'];
  if (likes is! num || points is! num || downloads is! num) {
    throw FormatException('Incomplete score for $name');
  }
  return _Score(likes: likes.toInt(), points: points.toInt(), downloads: downloads.toInt());
}

Future<PackageInfo> _fetchPackage(
  http.Client client,
  String name,
  _Score score,
  Map<String, Future<int>> starRequests,
) async {
  final json = _asMap(await _getJson(client, Uri.parse('$_pubApiRoot/packages/$name')));
  final pubspec = _asMap(_asMap(json['latest'])['pubspec']);
  final homepage = pubspec['homepage'] as String?;
  return PackageInfo(
    name: name,
    description: pubspec['description'] as String? ?? '',
    url: 'https://pub.dev/packages/$name',
    likes: score.likes,
    points: score.points,
    downloads: score.downloads,
    stars: await _starsFor(client, homepage, starRequests),
  );
}

Future<int> _starsFor(http.Client client, String? homepage, Map<String, Future<int>> starRequests) {
  const prefix = 'https://github.com/';
  if (homepage == null || !homepage.startsWith(prefix)) return Future.value(0);
  final parts = homepage.substring(prefix.length).split('/');
  if (parts.length < 2 || parts[0].isEmpty || parts[1].isEmpty) return Future.value(0);
  final owner = parts[0];
  final repo = parts[1];
  return starRequests.putIfAbsent('$owner/$repo', () async {
    final json = _asMap(await _getJson(client, Uri.https('api.github.com', '/repos/$owner/$repo')));
    return RepoInfo.fromGitHub(json).stars;
  });
}

Future<List<T>> _pool<T>(int maxConcurrent, List<Future<T> Function()> jobs) async {
  if (jobs.isEmpty) return [];
  final results = List<T?>.filled(jobs.length, null);
  var nextIndex = 0;

  Future<void> worker() async {
    while (true) {
      final index = nextIndex;
      if (index >= jobs.length) return;
      nextIndex++;
      results[index] = await jobs[index]();
    }
  }

  final workers = math.min(maxConcurrent, jobs.length);
  await Future.wait([for (var i = 0; i < workers; i++) worker()]);
  return [for (final result in results) result!];
}
