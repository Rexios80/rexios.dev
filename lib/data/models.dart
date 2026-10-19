import 'package:jaspr/jaspr.dart';

class RepoInfo {
  const RepoInfo({
    required this.name,
    required this.description,
    required this.htmlUrl,
    required this.watchers,
    required this.stars,
    required this.forks,
  });

  final String name;
  final String description;
  final String htmlUrl;
  final int watchers;
  final int stars;
  final int forks;

  factory RepoInfo.fromGitHub(Map<String, dynamic> json) {
    return RepoInfo(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      htmlUrl: json['html_url'] as String? ?? '',
      watchers: _asInt(json['subscribers_count']) ?? 0,
      stars: _asInt(json['stargazers_count']) ?? 0,
      forks: _asInt(json['forks_count']) ?? 0,
    );
  }

  @decoder
  static RepoInfo fromJson(Map<String, dynamic> json) {
    return RepoInfo(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      htmlUrl: json['htmlUrl'] as String? ?? '',
      watchers: _asInt(json['watchers']) ?? 0,
      stars: _asInt(json['stars']) ?? 0,
      forks: _asInt(json['forks']) ?? 0,
    );
  }

  @encoder
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'htmlUrl': htmlUrl,
      'watchers': watchers,
      'stars': stars,
      'forks': forks,
    };
  }
}

class PackageInfo {
  const PackageInfo({
    required this.name,
    required this.description,
    required this.url,
    required this.likes,
    required this.points,
    required this.downloads,
    required this.stars,
  });

  final String name;
  final String description;
  final String url;
  final int likes;
  final int points;
  final int? downloads;
  final int stars;

  @decoder
  static PackageInfo fromJson(Map<String, dynamic> json) {
    return PackageInfo(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      url: json['url'] as String? ?? '',
      likes: _asInt(json['likes']) ?? 0,
      points: _asInt(json['points']) ?? 0,
      downloads: _asInt(json['downloads']),
      stars: _asInt(json['stars']) ?? 0,
    );
  }

  @encoder
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'url': url,
      'likes': likes,
      'points': points,
      'downloads': downloads,
      'stars': stars,
    };
  }
}

int? _asInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return null;
}
