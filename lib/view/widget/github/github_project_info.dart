import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:rexios_dev/view/widget/item_stat.dart';

class GitHubProjectInfo extends StatelessWidget {
  static const _dividerWidth = 10.0;

  final Repository? repository;

  const GitHubProjectInfo({required this.repository, super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ItemStat(
            label: 'WATCHERS',
            value: repository?.subscribersCount.toString() ?? '0',
          ),
          const VerticalDivider(width: _dividerWidth),
          ItemStat(
            label: 'STARS',
            value: repository?.stargazersCount.toString() ?? '0',
          ),
          const VerticalDivider(width: _dividerWidth),
          ItemStat(
            label: 'FORKS',
            value: repository?.forksCount.toString() ?? '0',
          ),
        ],
      ),
    );
  }
}
