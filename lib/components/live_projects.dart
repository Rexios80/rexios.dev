import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:rexios_dev/components/project_widgets.dart';
import 'package:rexios_dev/data/format.dart';
import 'package:rexios_dev/data/models.dart';

class LiveProjects extends StatelessComponent {
  const LiveProjects({required this.repository, required this.repositories, required this.packages, super.key});

  final RepoInfo repository;
  final List<RepoInfo> repositories;
  final List<PackageInfo> packages;

  @override
  Component build(BuildContext context) {
    return .fragment([
      FeaturedProject(
        title: 'Health Data Server',
        stack: 'Flutter/Firebase/SwiftUI',
        description:
            'An application for collecting health data from a smart watch. This data can either be routed to a Twitch stream overlay through the cloud using Firebase or collected locally for anything you could want.',
        href: 'https://github.com/Rexios80/hds_overlay',
        imageSrc: 'images/hds.gif',
        imageAlt: 'Health Data Server',
        stats: [
          (label: 'WATCHERS', value: '${repository.watchers}'),
          (label: 'STARS', value: '${repository.stars}'),
          (label: 'FORKS', value: '${repository.forks}'),
        ],
      ),
      section(classes: 'project-section', [
        h2(classes: 'section-title', [.text('Top Dart/Flutter Packages')]),
        _packageList(),
      ]),
      section(classes: 'project-section', [
        h2(classes: 'section-title', [.text('Top GitHub Projects')]),
        _repositoryList(),
      ]),
    ]);
  }

  Component _packageList() {
    return div(classes: 'project-list', [
      for (final package in packages)
        ProjectCard(
          name: package.name,
          description: package.description,
          href: package.url,
          stats: [
            (label: 'LIKES', value: '${package.likes}'),
            (label: 'DOWNLOADS', value: formatLargeNum(package.downloads)),
            (label: 'STARS', value: '${package.stars}'),
          ],
        ),
    ]);
  }

  Component _repositoryList() {
    return div(classes: 'project-list', [
      for (final repository in repositories)
        ProjectCard(
          name: repository.name,
          description: repository.description,
          href: repository.htmlUrl,
          stats: [
            (label: 'WATCHERS', value: '${repository.watchers}'),
            (label: 'STARS', value: '${repository.stars}'),
            (label: 'FORKS', value: '${repository.forks}'),
          ],
        ),
    ]);
  }
}
