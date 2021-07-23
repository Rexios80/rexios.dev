import 'package:get/get.dart';
import 'package:pub_api_client/pub_api_client.dart';

class FlutterPluginsController extends GetxController {
  final _client = PubClient();

  RxMap<String, PackageMetricsInfo> packageMetricsInfos = RxMap();

  FlutterPluginsController() {
    _init();
  }

  void _init() async {
    final packages = await _getPackages();
    packageMetricsInfos.value = await _getMetricsInfos(packages: packages);
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

  Future<Map<String, PackageMetricsInfo>> _getMetricsInfos({
    required List<String> packages,
  }) async {
    final scoreCardMap = <String, PackageMetricsInfo>{};
    packages.forEach((package) async {
      final metrics = await _client.packageMetrics(package);
      final info = await _client.packageInfo(package);
      scoreCardMap[package] = PackageMetricsInfo(metrics: metrics, info: info);
    });
    return scoreCardMap;
  }
}

class PackageMetricsInfo {
  final PackageMetrics metrics;
  final PubPackage info;

  PackageMetricsInfo({required this.metrics, required this.info});
}
