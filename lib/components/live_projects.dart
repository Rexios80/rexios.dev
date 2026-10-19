import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:rexios_dev/components/project_widgets.dart';
import 'package:rexios_dev/data/format.dart';
import 'package:rexios_dev/data/models.dart';
import 'package:rexios_dev/data/portfolio_api.dart';

@client
class LiveProjects extends StatefulComponent {
  const LiveProjects({required this.repository, required this.repositories, required this.packages, super.key});

  final RepoInfo? repository;
  final List<RepoInfo>? repositories;
  final List<PackageInfo>? packages;

  @override
  State<LiveProjects> createState() => LiveProjectsState();
}

class LiveProjectsState extends State<LiveProjects> {
  late RepoInfo? _repository = component.repository;
  late List<RepoInfo>? _repositories = component.repositories;
  late List<PackageInfo>? _packages = component.packages;
  String? _packagesError;
  String? _repositoriesError;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _refresh();
    }
  }

  Future<void> _refresh() async {
    final data = await loadPortfolio();
    if (!mounted) return;
    setState(() {
      _repository = data.hds ?? _repository;
      if (data.repositories != null) _repositories = data.repositories;
      if (data.packages != null) _packages = data.packages;
      _packagesError = _packages == null ? "Couldn't load packages." : null;
      _repositoriesError = _repositories == null ? "Couldn't load projects." : null;
    });
  }

  @override
  Component build(BuildContext context) {
    final repository = _repository;
    return .fragment([
      section(classes: 'project-section', [
        h2(classes: 'section-title', [.text('Health Data Server')]),
        p(classes: 'section-subtitle', [.text('(Flutter/Firebase/SwiftUI)')]),
        div(classes: 'stats-center', [
          Stats(
            items: [
              (label: 'WATCHERS', value: '${repository?.watchers ?? 0}'),
              (label: 'STARS', value: '${repository?.stars ?? 0}'),
              (label: 'FORKS', value: '${repository?.forks ?? 0}'),
            ],
          ),
        ]),
        p(classes: 'project-copy', [
          a(
            href: 'https://github.com/Rexios80/hds_overlay',
            target: .blank,
            referrerPolicy: .noReferrer,
            attributes: {'rel': 'noopener noreferrer'},
            [.text('Health Data Server')],
          ),
          .text(
            ' is an application for collecting health data from a smart watch. This data can either be routed to a Twitch stream overlay through the cloud using Firebase or collected locally for anything you could want.',
          ),
        ]),
        img(classes: 'project-image', src: 'images/hds.gif', alt: 'Health Data Server'),
      ]),
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
    final packages = _packages;
    if (packages == null) return _status(_packagesError, 'Loading packages');
    return div(classes: 'project-list', [
      for (final package in packages)
        ProjectCard(
          name: package.name,
          description: package.description,
          href: package.url,
          stats: [
            (label: 'LIKES', value: '${package.likes}'),
            (label: 'PUB POINTS', value: '${package.points}'),
            (label: 'DOWNLOADS', value: formatLargeNum(package.downloads)),
            (label: 'STARS', value: '${package.stars}'),
          ],
        ),
    ]);
  }

  Component _repositoryList() {
    final repositories = _repositories;
    if (repositories == null) return _status(_repositoriesError, 'Loading projects');
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

  Component _status(String? error, String label) {
    if (error != null) return p(classes: 'status-text', [.text(error)]);
    return div(classes: 'spinner', attributes: {'role': 'status', 'aria-label': label}, []);
  }
}
