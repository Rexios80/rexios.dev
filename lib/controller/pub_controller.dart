import 'package:get_it/get_it.dart';
import 'package:github/github.dart';
import 'package:pub_api_client/pub_api_client.dart';
import 'package:collection/collection.dart';
import 'package:fast_ui/fast_ui.dart';
import 'package:rexios_dev/model/package_score_info.dart';
import 'package:rexios_dev/service/github_service.dart';

class PubController {
  static const _myPublishers = [
    'rexios.dev',
    'vrchat.community',
    'iodesignteam.com',
  ];

  final _pub = PubClient(pubUrl: 'https://proxy.rexios.dev/pub');
  final _github = GetIt.I<GitHubService>();

  final packageScoreInfos = RxList<PackageScoreInfo>();

  PubController() {
    _init();
  }

  void _init() async {
    final packageResults = <PackageResult>[];
    for (final publisher in _myPublishers) {
      final results = await _pub.fetchPublisherPackages(publisher);
      packageResults.addAll(results);
    }
    final infos =
        await _getMetricsInfos(results: packageResults);
    packageScoreInfos.clear();
    packageScoreInfos.addAll(infos);
  }

  Future<List<PackageScoreInfo>> _getMetricsInfos({
    required List<PackageResult> results,
  }) async {
    final infos = <PackageScoreInfo>[];
    final futures = results.map((result) async {
      final options = await _pub.packageOptions(result.package);

      // Don't show unlisted or discontinued packages
      if (options.isUnlisted || options.isDiscontinued) {
        return;
      }

      final score = await _pub.packageScore(result.package);
      final info = await _pub.packageInfo(result.package);
      final stars = await _getStars(info);
      infos.add(PackageScoreInfo(score: score, info: info, stars: stars));
    });

    await Future.wait(futures);

    // Sort by popularity
    return infos.sorted(
      (a, b) =>
          b.score.popularityScore?.compareTo(a.score.popularityScore ?? -1) ??
          -1,
    );
  }

  Future<int> _getStars(PubPackage package) async {
    final gitHubPath =
        package.latestPubspec.homepage?.replaceAll('https://github.com/', '');
    if (gitHubPath == null) return 0;
    final split = gitHubPath.split('/');

    final user = split[0];
    final repo = split[1];
    final slug = RepositorySlug(user, repo);
    final repository = await _github.getRepository(slug);

    return repository.stargazersCount;
  }
}
