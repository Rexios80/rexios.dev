import 'package:flutter/material.dart';
import 'package:fast_ui/fast_ui.dart';
import 'package:rexios_dev/model/package_score_info.dart';

class PubPackageScore extends StatelessWidget {
  static const _dividerWidth = 10.0;

  final PackageScoreInfo package;

  const PubPackageScore({required this.package, super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Text(package.score.likeCount.toString()),
              const SizedBox(height: 3),
              Text(
                'LIKES',
                style: context.textTheme.bodySmall!.copyWith(fontSize: 8),
              ),
            ],
          ),
          const VerticalDivider(width: _dividerWidth),
          Column(
            children: [
              Text(package.score.grantedPoints.toString()),
              const SizedBox(height: 3),
              Text(
                'PUB POINTS',
                style: context.textTheme.bodySmall!.copyWith(fontSize: 8),
              ),
            ],
          ),
          const VerticalDivider(width: _dividerWidth),
          Column(
            children: [
              Text(
                package.score.popularityScore != null
                    ? '${(package.score.popularityScore! * 100).toStringAsFixed(0)}%'
                    : '-',
              ),
              const SizedBox(height: 3),
              Text(
                'POPULARITY',
                style: context.textTheme.bodySmall!.copyWith(fontSize: 8),
              ),
            ],
          ),
          const VerticalDivider(width: _dividerWidth),
          Column(
            children: [
              Text(package.stars.toString()),
              const SizedBox(height: 3),
              Text(
                'STARS',
                style: context.textTheme.bodySmall!.copyWith(fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
