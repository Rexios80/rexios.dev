import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

typedef StatItem = ({String label, String value});

class FeaturedProject extends StatelessComponent {
  const FeaturedProject({
    required this.title,
    required this.stack,
    required this.description,
    required this.href,
    required this.imageSrc,
    required this.imageAlt,
    this.stats,
    super.key,
  });

  final String title;
  final String stack;
  final String description;
  final String href;
  final String imageSrc;
  final String imageAlt;
  final List<StatItem>? stats;

  @override
  Component build(BuildContext context) {
    final stats = this.stats;
    return section(classes: 'project-section featured', [
      a(
        classes: 'featured-media',
        href: href,
        target: .blank,
        referrerPolicy: .noReferrer,
        attributes: {'rel': 'noopener noreferrer'},
        [img(classes: 'project-image', src: imageSrc, alt: imageAlt)],
      ),
      div(classes: 'featured-body', [
        h2(classes: 'section-title', [.text(title)]),
        p(classes: 'section-subtitle', [.text(stack)]),
        if (stats != null) Stats(items: stats),
        p(classes: 'project-copy', [.text(description)]),
      ]),
    ]);
  }
}

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
