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
              !_repos.contains(repo.slug()) &&
              !repo.isFork &&
              repo.description.isNotEmpty &&
              // Invisible characters to say this repo should not be shown on the site
              !repo.description.contains('‎‎‎‎‎'),
        )
        .listen(otherRepos.add);
  }
}
