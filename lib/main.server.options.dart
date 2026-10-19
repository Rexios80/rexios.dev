// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:rexios_dev/components/contact_bar.dart' as _contact_bar;
import 'package:rexios_dev/styles.dart' as _styles;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {
    _contact_bar.DiscordCard: ClientTarget<_contact_bar.DiscordCard>(
      'contact_bar',
      params: __contact_barDiscordCard,
    ),
  },
  styles: () => [..._styles.styles],
);

Map<String, Object?> __contact_barDiscordCard(_contact_bar.DiscordCard c) => {
  'href': c.href,
  'name': c.name,
  'online': c.online,
  'members': c.members,
};
