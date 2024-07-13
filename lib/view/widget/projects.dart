import 'package:fast_ui/fast_ui.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rexios_dev/controller/github_controller.dart';
import 'package:rexios_dev/view/widget/asset_markdown_body.dart';
import 'package:rexios_dev/view/widget/github/github_project_info.dart';
import 'package:rexios_dev/view/widget/github/github_projects.dart';
import 'package:rexios_dev/view/widget/pub/pub_packages.dart';

class Projects extends StatelessWidget {
  final _controller = GetIt.I<GitHubController>();

  Projects({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'My Projects',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 40),
        Text(
          'Project Madad Maps',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          '(Flutter/Firebase)',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 20),
        const AssetMarkdownBody('assets/strings/pmm.txt'),
        const SizedBox(height: 20),
        Image.asset('assets/images/pmm.png'),
        const SizedBox(height: 80),
        Text(
          'Health Data Server',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          '(Flutter/Firebase/SwiftUI)',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FastBuilder(
              () => GitHubProjectInfo(
                repository: _controller.repoMap[GitHubController.hdsSlug],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const AssetMarkdownBody('assets/strings/hds.txt'),
        const SizedBox(height: 20),
        Image.asset('assets/images/hds.gif'),
        const SizedBox(height: 80),
        Text(
          'Top Dart/Flutter Packages',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        PubPackages(),
        const SizedBox(height: 80),
        Text(
          'Top GitHub Projects',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        GitHubProjects(),
      ],
    );
  }
}
