import 'package:jaspr/jaspr.dart';
import 'package:rexios_dev/components/project_widgets.dart';

class MadadSection extends StatelessComponent {
  const MadadSection({super.key});

  @override
  Component build(BuildContext context) {
    return const FeaturedProject(
      title: 'Project Madad Maps',
      stack: 'Flutter/Firebase',
      description:
          'A live updating map of hospital bed availability in India. India currently has no centralized method of showing this information. A Firebase Cloud Function periodically scrapes hundreds of websites to get the hospital bed availability data and stores it in a Realtime Database for the website to access.',
      href: 'https://beta.madadmaps.com',
      imageSrc: 'images/pmm.png',
      imageAlt: 'Project Madad Maps',
    );
  }
}
