import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

typedef StatItem = ({String label, String value});

class Stats extends StatelessComponent {
  const Stats({required this.items, super.key});

  final List<StatItem> items;

  @override
  Component build(BuildContext context) {
    return div(classes: 'stats', [
      for (final item in items)
        div(classes: 'stat', [
          span(classes: 'stat-value', [.text(item.value)]),
          span(classes: 'stat-label', [.text(item.label)]),
        ]),
    ]);
  }
}

class ProjectCard extends StatelessComponent {
  const ProjectCard({
    required this.name,
    required this.description,
    required this.href,
    required this.stats,
    super.key,
  });

  final String name;
  final String description;
  final String href;
  final List<StatItem> stats;

  @override
  Component build(BuildContext context) {
    return a(
      classes: 'project-card',
      href: href,
      target: .blank,
      referrerPolicy: .noReferrer,
      attributes: {'rel': 'noopener noreferrer'},
      [
        div(classes: 'project-card-header', [
          span(classes: 'project-name', [.text(name)]),
          Stats(items: stats),
        ]),
        p(classes: 'project-description', [.text(description)]),
      ],
    );
  }
}
