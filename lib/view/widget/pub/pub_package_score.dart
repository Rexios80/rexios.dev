import 'package:flutter/material.dart';
import 'package:rexios_dev/model/package_score_info.dart';
import 'package:rexios_dev/util/format_utils.dart';
import 'package:rexios_dev/view/widget/item_stat.dart';

class PubPackageScore extends StatelessWidget {
  static const _dividerWidth = 10.0;

  final PackageScoreInfo package;

  const PubPackageScore({required this.package, super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ItemStat(label: 'LIKES', value: package.score.likeCount.toString()),
          const VerticalDivider(width: _dividerWidth),
          ItemStat(
            label: 'PUB POINTS',
            value: package.score.grantedPoints.toString(),
          ),
          const VerticalDivider(width: _dividerWidth),
          ItemStat(
            label: 'DOWNLOADS',
            value: formatLargeNum(package.score.downloadCount30Days),
          ),
          const VerticalDivider(width: _dividerWidth),
          ItemStat(label: 'STARS', value: package.stars.toString()),
        ],
      ),
    );
  }
}
