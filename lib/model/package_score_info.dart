import 'package:pub_api_client/pub_api_client.dart';

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
