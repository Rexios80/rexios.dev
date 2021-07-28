import 'package:get/get.dart';
import 'package:github/github.dart';
import 'package:rexios_dev/view/widgets/controllers/github_controller.dart';

class ProjectsController extends GetxController {
  static final hdsSlug = RepositorySlug(
    'Rexios80',
    'Health-Data-Server-Overlay',
  );

  final GithubController _github = Get.find();
  final repoMap = RxMap<RepositorySlug, Repository>();

  ProjectsController() {
    _github
        .getRepository(hdsSlug)
        .then((repository) => repoMap[hdsSlug] = repository);
  }
}
