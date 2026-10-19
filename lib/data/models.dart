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

class ProfileStats {
  const ProfileStats({required this.github, required this.x, required this.discord});

  final GitHubProfile github;
  final XProfile x;
  final DiscordProfile discord;
}

class GitHubProfile {
  const GitHubProfile({required this.login, required this.followers});

  final String login;
  final int followers;

  String get href => 'https://github.com/$login';

  factory GitHubProfile.fromGitHub(Map<String, dynamic> json) {
    return GitHubProfile(
      login: _requireString(json['login'], 'login'),
      followers: _requireInt(json['followers'], 'followers'),
    );
  }
}

class XProfile {
  const XProfile({required this.screenName, required this.followers});

  final String screenName;
  final int followers;

  String get href => 'https://x.com/$screenName';

  factory XProfile.fromApi(Map<String, dynamic> json) {
    return XProfile(
      screenName: _requireString(json['screen_name'], 'screen_name'),
      followers: _requireInt(json['followers_count'], 'followers_count'),
    );
  }
}

class DiscordProfile {
  const DiscordProfile({required this.name, required this.online, required this.members, required this.href});

  final String name;
  final int online;
  final int members;
  final String href;

  factory DiscordProfile.fromInvite(Map<String, dynamic> json, {required String href}) {
    final guild = json['guild'];
    final name = guild is Map ? guild['name'] : null;
    return DiscordProfile(
      name: _requireString(name, 'guild.name'),
      online: _requireInt(json['approximate_presence_count'], 'approximate_presence_count'),
      members: _requireInt(json['approximate_member_count'], 'approximate_member_count'),
      href: href,
    );
  }
}

int _requireInt(Object? value, String field) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  throw FormatException('Expected a number for $field');
}

String _requireString(Object? value, String field) {
  if (value is String && value.isNotEmpty) return value;
  throw FormatException('Expected text for $field');
}
