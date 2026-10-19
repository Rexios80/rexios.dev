import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:rexios_dev/app.dart';

import 'main.server.options.dart';
import 'styles.dart';

void main() {
  if (styles.isEmpty) {
    throw StateError('Missing styles');
  }

  Jaspr.initializeApp(options: defaultServerOptions);

  runApp(
    Document(
      title: 'Rexios',
      lang: 'en',
      meta: const {'description': "Hi! I'm Rexios.", 'theme-color': '#FF9800'},
      head: [
        link(rel: 'icon', href: 'favicon.png', type: 'image/png'),
        link(rel: 'apple-touch-icon', href: 'icons/Icon-192.png'),
        link(rel: 'manifest', href: 'manifest.json'),
        meta(name: 'apple-mobile-web-app-capable', content: 'yes'),
        meta(name: 'apple-mobile-web-app-status-bar-style', content: 'black'),
        meta(name: 'apple-mobile-web-app-title', content: 'Rexios'),
        script(src: 'https://www.googletagmanager.com/gtag/js?id=G-DWC3HXPP1K', async: true),
        script(
          content: '''
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());
gtag('config', 'G-DWC3HXPP1K');
''',
        ),
      ],
      body: const App(),
    ),
  );
}
