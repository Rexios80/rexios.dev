import 'package:flutter/foundation.dart';
import 'package:pub_api_client/pub_api_client.dart';

@immutable
class PackageScoreInfo {
  final PackageScore score;
  final PubPackage info;
  final int stars;

  const PackageScoreInfo({
    required this.score,
    required this.info,
    required this.stars,
  });
}
