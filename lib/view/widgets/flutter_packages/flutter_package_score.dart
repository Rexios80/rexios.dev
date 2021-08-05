import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rexios_dev/view/widgets/controllers/flutter_packages_controller.dart';

class FlutterPackageScore extends StatelessWidget {
  static const _dividerWidth = 10.0;

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
              SizedBox(height: 3),
              Text(
                'LIKES',
                style: Get.textTheme.caption!.copyWith(fontSize: 8),
              ),
            ],
          ),
          VerticalDivider(width: _dividerWidth),
          Column(
            children: [
              Text(package.score.grantedPoints?.toString() ?? '-'),
              SizedBox(height: 3),
              Text(
                'PUB POINTS',
                style: Get.textTheme.caption!.copyWith(fontSize: 8),
              ),
            ],
          ),
          VerticalDivider(width: _dividerWidth),
          Column(
            children: [
              Text(
                package.score.popularityScore != null
                    ? (package.score.popularityScore! * 100)
                            .toStringAsFixed(0) +
                        '%'
                    : '-',
              ),
              SizedBox(height: 3),
              Text(
                'POPULARITY',
                style: Get.textTheme.caption!.copyWith(fontSize: 8),
              ),
            ],
          ),
          VerticalDivider(width: _dividerWidth),
          Column(
            children: [
              Text(package.stars.toString()),
              SizedBox(height: 3),
              Text(
                'STARS',
                style: Get.textTheme.caption!.copyWith(fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
