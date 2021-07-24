import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rexios_dev/view/widgets/controllers/flutter_packages_controller.dart';

class FlutterPackageScore extends StatelessWidget {
  final PackageScoreInfo package;

  const FlutterPackageScore({required this.package});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Text(package.score.likeCount.toString()),
              Text(
                'LIKES',
                style: Get.textTheme.caption!.copyWith(fontSize: 8),
              ),
            ],
          ),
          VerticalDivider(),
          Column(
            children: [
              Text(package.score.grantedPoints.toString()),
              Text(
                'PUB POINTS',
                style: Get.textTheme.caption!.copyWith(fontSize: 8),
              ),
            ],
          ),
          VerticalDivider(),
          Column(
            children: [
              Text((package.score.popularityScore * 100).toStringAsFixed(0) +
                  '%'),
              Text(
                'POPULARITY',
                style: Get.textTheme.caption!.copyWith(fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
