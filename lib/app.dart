import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:rexios_dev/components/contact_bar.dart';
import 'package:rexios_dev/components/live_projects.dart';
import 'package:rexios_dev/components/madad_section.dart';
import 'package:rexios_dev/components/project_widgets.dart';
import 'package:rexios_dev/data/format.dart';
import 'package:rexios_dev/data/portfolio_api.dart';

class App extends AsyncStatelessComponent {
  const App({super.key});

  @override
  Future<Component> build(BuildContext context) async {
    final data = await loadPortfolio();
    return .fragment([
      main_(classes: 'page', [
        header(classes: 'page-header', [
          div(classes: 'page-heading', [
            h1(classes: 'page-title', [.text('My Projects')]),
            p(classes: 'page-intro', [.text("Hi! I'm Rexios.")]),
          ]),
          ContactBar(profiles: data.profiles),
        ]),
        FeaturedProject(
          title: 'Hive CE',
          stack: 'Dart/Flutter',
          description:
              'A lightweight key-value database written in pure Dart, and the community continuation of the very popular Hive package. On top of Hive v2 it adds isolate support, Flutter web WASM, a DevTools inspector, automatic type adapter generation, and more.',
          href: data.hiveCe.url,
          imageSrc: 'images/hive_ce.png',
          imageAlt: 'hive_ce listed among the top Flutter packages on pub.dev',
          stats: [
            (label: 'LIKES', value: '${data.hiveCe.likes}'),
            (label: 'DOWNLOADS', value: formatLargeNum(data.hiveCe.downloads)),
            (label: 'STARS', value: '${data.hiveCe.stars}'),
          ],
        ),
        const MadadSection(),
        LiveProjects(repository: data.hds, repositories: data.repositories, packages: data.packages),
        div(classes: 'built-with', [
          a(
            href: 'https://jaspr.site',
            target: .blank,
            referrerPolicy: .noReferrer,
            attributes: {'rel': 'noopener noreferrer'},
            [const JasprBadge.light()],
          ),
        ]),
      ]),
    ]);
  }
}
