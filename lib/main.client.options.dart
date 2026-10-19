// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:rexios_dev/components/contact_bar.dart'
    deferred as _contact_bar;

/// Default [ClientOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.client.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultClientOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ClientOptions get defaultClientOptions => ClientOptions(
  clients: {
    'contact_bar': ClientLoader(
      (p) => _contact_bar.DiscordCard(
        href: p['href'] as String,
        name: p['name'] as String,
        online: p['online'] as int,
        members: p['members'] as int,
      ),
      loader: _contact_bar.loadLibrary,
    ),
  },
);
