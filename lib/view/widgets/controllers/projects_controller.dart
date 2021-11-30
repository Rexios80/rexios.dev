import 'package:get/get.dart';
import 'package:github/github.dart';
import 'package:rexios_dev/view/widgets/controllers/github_controller.dart';

class ProjectsController extends GetxController {
  static final hdsSlug = RepositorySlug(
    'Rexios80',
    'Health-Data-Server-Overlay',
  );

  static final _repos = [hdsSlug];

  final GithubController _github = Get.find();
  final repoMap = RxMap<RepositorySlug, Repository>();
  final otherRepos = RxList<Repository>();

  ProjectsController() {
    for (var slug in _repos) {
      _github
          .getRepository(slug)
          .then((repository) => repoMap[slug] = repository);
    }
    _github.repositoryStream
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
              // Special string to force ignore a repo
              !repo.description.contains('rexios.dev:ignore'),
        )
        .listen(otherRepos.add);
  }
}
