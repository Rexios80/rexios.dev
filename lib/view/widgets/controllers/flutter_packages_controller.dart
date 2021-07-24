import 'package:get/get.dart';
import 'package:pub_api_client/pub_api_client.dart';

class FlutterPackagesController extends GetxController {
  final _client = PubClient(pubUrl: 'https://proxy.rexios.dev/pub');

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
        await _client.search('', publisher: 'rexios.dev', page: page);
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
      final score = await _client.packageScore(package);
      final info = await _client.packageInfo(package);
      scoreCards.add(PackageScoreInfo(score: score, info: info));
    }
    return scoreCards;
  }
}

class PackageScoreInfo {
  final PackageScore score;
  final PubPackage info;

  PackageScoreInfo({required this.score, required this.info});
}
