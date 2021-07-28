import 'package:get/get.dart';
import 'package:github/github.dart';
import 'package:pub_api_client/pub_api_client.dart';
import 'package:rexios_dev/view/widgets/controllers/github_controller.dart';

class FlutterPackagesController extends GetxController {
  final _pubClient = PubClient(pubUrl: 'https://proxy.rexios.dev/pub/');
  final GithubController _github = Get.find();

  RxList<PackageScoreInfo> packageScoreInfos = RxList();

  FlutterPackagesController() {
    _init();
  }

  void _init() async {
    final packages = await _getPackages();
    packageScoreInfos.value = await _getMetricsInfos(packages: packages);
  }

  Future<List<String>> _getPackages({
    int page = 1,
  }) async {
    final results =
        await _pubClient.search('', publisher: 'rexios.dev', page: page);
    final packages = results.packages.map((e) => e.package).toList();
    if (packages.isEmpty) {
      // Terminating condition
      // There were no results for this page
      return [];
    } else {
      return packages + await _getPackages(page: page + 1);
    }
  }

  Future<List<PackageScoreInfo>> _getMetricsInfos({
    required List<String> packages,
  }) async {
    final scoreCards = <PackageScoreInfo>[];
    for (final package in packages) {
      final score = await _pubClient.packageScore(package);
      final info = await _pubClient.packageInfo(package);
      final stars = await _getStars(info);
      scoreCards.add(PackageScoreInfo(score: score, info: info, stars: stars));
    }
    return scoreCards;
  }

  Future<int> _getStars(PubPackage package) async {
    final split = package.latestPubspec.homepage?.split('/');
    if (split == null) return 0;

    final user = split[split.length - 2];
    final repo = split.last;
    final slug = RepositorySlug(user, repo);
    final repository = await _github.getRepository(slug);

    return repository.stargazersCount;
  }
}

class PackageScoreInfo {
  final PackageScore score;
  final PubPackage info;
  final int stars;

  PackageScoreInfo({
    required this.score,
    required this.info,
    required this.stars,
  });
}
