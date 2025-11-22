import 'package:flutter/material.dart';
import 'package:github/github.dart';

class GitHubProjectInfo extends StatelessWidget {
  static const _dividerWidth = 10.0;

  final Repository? repository;

  const GitHubProjectInfo({required this.repository, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Text(repository?.subscribersCount.toString() ?? '0'),
              const SizedBox(height: 3),
              Text(
                'WATCHERS',
                style: textTheme.bodySmall?.copyWith(fontSize: 8),
              ),
            ],
          ),
          const VerticalDivider(width: _dividerWidth),
          Column(
            children: [
              Text(repository?.stargazersCount.toString() ?? '0'),
              const SizedBox(height: 3),
              Text(
                'STARS',
                style: textTheme.bodySmall?.copyWith(fontSize: 8),
              ),
            ],
          ),
          const VerticalDivider(width: _dividerWidth),
          Column(
            children: [
              Text(repository?.forksCount.toString() ?? '0'),
              const SizedBox(height: 3),
              Text(
                'FORKS',
                style: textTheme.bodySmall?.copyWith(fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
