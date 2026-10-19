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
      watchers: _requireInt(json['subscribers_count'], 'subscribers_count'),
      stars: _requireInt(json['stargazers_count'], 'stargazers_count'),
      forks: _requireInt(json['forks_count'], 'forks_count'),
    );
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
  final int downloads;
  final int stars;
}

int _requireInt(Object? value, String field) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  throw FormatException('Expected a number for $field');
}
