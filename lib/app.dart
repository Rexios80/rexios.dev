import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:rexios_dev/components/contact_bar.dart';
import 'package:rexios_dev/components/live_projects.dart';
import 'package:rexios_dev/components/madad_section.dart';
import 'package:rexios_dev/data/portfolio_api.dart';

class App extends AsyncStatelessComponent {
  const App({super.key});

  @override
  Future<Component> build(BuildContext context) async {
    final data = await loadPortfolio();
    return .fragment([
      main_(classes: 'page', [
        h1(classes: 'page-title', [.text('My Projects')]),
        const MadadSection(),
        LiveProjects(repository: data.hds, repositories: data.repositories, packages: data.packages),
        p(classes: 'rendered-with', [.text('Rendered with Jaspr')]),
      ]),
      const ContactBar(),
    ]);
  }
}
