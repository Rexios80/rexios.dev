import 'package:get_it/get_it.dart';
import 'package:github/github.dart';
import 'package:fast_ui/fast_ui.dart';
import 'package:rexios_dev/service/github_service.dart';

class GitHubController {
  static final hdsSlug = RepositorySlug('Rexios80', 'hds_overlay');
  static final _repos = [hdsSlug];

  final _github = GetIt.I<GitHubService>();

  final repoMap = RxMap<RepositorySlug, Repository>();
  final otherRepos = RxList<Repository>();

  GitHubController() {
    _init();
  }

  void _init() async {
    for (final slug in _repos) {
      final repo = await _github.getRepository(slug);
      repoMap[slug] = repo;
    }
    final stream = _github.repositoryStream;
    stream
        .where(
          (repo) =>
              // Don't show repos that are handled individually
              !_repos.contains(repo.slug()) &&
              // Don't show forks
              !repo.isFork &&
              // Don't show Flutter/Dart package repos
              !repo.homepage.contains('pub.dev') &&
              // Don't show repos that don't have a description
              repo.description.isNotEmpty &&
              // Don't show archived repos
              !repo.archived &&
              // Special string to force ignore a repo
              !repo.description.contains('rexios.dev:ignore'),
        )
        .listen(otherRepos.add);
    await stream.last;
    otherRepos.sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
  }
}
