import 'package:get/get.dart';
import 'package:github/github.dart';
import 'package:pub_api_client/pub_api_client.dart';
import 'package:rexios_dev/view/widgets/controllers/github_controller.dart';
import 'package:collection/collection.dart';

class FlutterPackagesController extends GetxController {
  final _pubClient = PubClient(pubUrl: 'https://proxy.rexios.dev/pub');
  final GithubController _github = Get.find();

  RxList<PackageScoreInfo> packageScoreInfos = RxList();

  FlutterPackagesController() {
    _init();
  }

  void _init() async {
    final rexiosPackages = await _getPackages(publisher: 'rexios.dev');
    final vrchatPackages = await _getPackages(publisher: 'vrchat.community');
    packageScoreInfos.value = await _getMetricsInfos(
      packages: rexiosPackages + vrchatPackages,
    );
  }

  Future<List<String>> _getPackages({
    required String publisher,
    int page = 1,
  }) async {
    final results =
        await _pubClient.search(publisher: publisher, page: page);
    final packages = results.packages.map((e) => e.package).toList();
    if (packages.isEmpty) {
      // Terminating condition
      // There were no results for this page
      return [];
    } else {
      return packages +
          await _getPackages(
            publisher: publisher,
            page: page + 1,
          );
    }
  }

  Future<List<PackageScoreInfo>> _getMetricsInfos({
    required List<String> packages,
  }) async {
    final scoreCards = <PackageScoreInfo>[];
    for (final package in packages) {
      final options = await _pubClient.packageOptions(package);

      // Don't show unlisted or discontinued packages
      if (options.isUnlisted || options.isDiscontinued) {
        continue;
      }

      final score = await _pubClient.packageScore(package);
      final info = await _pubClient.packageInfo(package);
      final stars = await _getStars(info);
      scoreCards.add(PackageScoreInfo(score: score, info: info, stars: stars));
    }

    // Sort by popularity
    return scoreCards.sorted(
      (a, b) =>
          b.score.popularityScore?.compareTo(a.score.popularityScore ?? -1) ??
          -1,
    );
  }

  Future<int> _getStars(PubPackage package) async {
    final gitHubPath = package.latestPubspec.homepage?.replaceAll('https://github.com/', '');
    if (gitHubPath == null) return 0;
    final split = gitHubPath.split('/');

    final user = split[0];
    final repo = split[1];
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
