import 'dart:async';

import 'package:flutter_tools_task_queue/flutter_tools_task_queue.dart';
import 'package:get_it/get_it.dart';
import 'package:github/github.dart';
import 'package:pub_api_client/pub_api_client.dart';
import 'package:collection/collection.dart';
import 'package:fast_ui/fast_ui.dart';
import 'package:rexios_dev/model/package_score_info.dart';
import 'package:rexios_dev/service/github_service.dart';

class PubController {
  static const _myPublishers = [
    'rexios.dev',
    'vrchat.community',
    'iodesignteam.com',
  ];

  final _pub = PubClient(pubUrl: 'https://proxy.rexios.dev/pub', debug: true);
  final _github = GetIt.I<GitHubService>();

  final packageScoreInfos = RxList<PackageScoreInfo>();

  PubController() {
    _init();
  }

  void _init() async {
    final packageResults = <PackageResult>[];
    for (final publisher in _myPublishers) {
      final results = await _pub.fetchPublisherPackages(publisher);
      packageResults.addAll(results);
    }
    final infos = await _getMetricsInfos(
      packages: packageResults.map((e) => e.package).toList(),
    );
    packageScoreInfos.addAll(infos);
  }

  Future<List<PackageScoreInfo>> _getMetricsInfos({
    required List<String> packages,
  }) async {
    final queue = TaskQueue(maxJobs: 8);

    final scores = <String, PackageScore>{};
    for (final package in packages) {
      unawaited(
        queue.add(() async {
          final score = await _pub
              .packageScore(package)
              .timeout(const Duration(seconds: 1));
          scores[package] = score;
        }),
      );
    }

    await queue.tasksComplete;

    final infos = <PackageScoreInfo>[];
    final sortedScores = scores.entries
        .where((e) => e.value.popularityScore != null)
        .sorted(
          (a, b) =>
              b.value.popularityScore!.compareTo(a.value.popularityScore!),
        )
        .toList();

    // There is a variable number of packages to parse depending on if any fail
    var packageCount = 10;
    for (var i = 0; i < packageCount && i < sortedScores.length; i++) {
      final entry = sortedScores[i];
      final package = entry.key;
      final score = entry.value;

      unawaited(
        queue.add(() async {
          try {
            final info = await _pub
                .packageInfo(package)
                .timeout(const Duration(seconds: 1));
            final stars =
                await _getStars(info).timeout(const Duration(seconds: 1));
            infos.add(PackageScoreInfo(score: score, info: info, stars: stars));
          } catch (e) {
            print('Error getting package info for $package: $e');
            packageCount++;
          }
        }),
      );
    }

    await queue.tasksComplete;

    // Sort by popularity
    return infos.sorted(
      (a, b) =>
          b.score.popularityScore?.compareTo(a.score.popularityScore ?? -1) ??
          -1,
    );
  }

  Future<int> _getStars(PubPackage package) async {
    final gitHubPath =
        package.latestPubspec.homepage?.replaceAll('https://github.com/', '');
    if (gitHubPath == null) return 0;
    final split = gitHubPath.split('/');

    final user = split[0];
    final repo = split[1];
    final slug = RepositorySlug(user, repo);
    final repository = await _github.getRepository(slug);

    return repository.stargazersCount;
  }
}
