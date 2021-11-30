import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github/github.dart';

class GitHubInfo extends StatelessWidget {
  static const _dividerWidth = 10.0;

  final Repository? repository;

  const GitHubInfo({required this.repository, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Text(repository?.subscribersCount.toString() ?? '0'),
              const SizedBox(height: 3),
              Text(
                'WATCHERS',
                style: Get.textTheme.caption!.copyWith(fontSize: 8),
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
                style: Get.textTheme.caption!.copyWith(fontSize: 8),
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
                style: Get.textTheme.caption!.copyWith(fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
