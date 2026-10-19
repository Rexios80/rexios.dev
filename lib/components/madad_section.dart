import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class MadadSection extends StatelessComponent {
  const MadadSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(classes: 'project-section', [
      h2(classes: 'section-title', [.text('Project Madad Maps')]),
      p(classes: 'section-subtitle', [.text('(Flutter/Firebase)')]),
      p(classes: 'project-copy', [
        a(
          href: 'https://madadmaps.com',
          target: .blank,
          referrerPolicy: .noReferrer,
          attributes: {'rel': 'noopener noreferrer'},
          [.text('Project Madad Maps')],
        ),
        .text(
          ' is a live updating map of hospital bed availability in India. India currently has no centralized method of showing this information. A Firebase Cloud Function periodically scrapes hundreds of websites to get the hospital bed availability data and stores it in a Realtime Database for the website to access.',
        ),
      ]),
      img(classes: 'project-image', src: 'images/pmm.png', alt: 'Project Madad Maps'),
    ]);
  }
}
