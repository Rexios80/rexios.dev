// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:rexios_dev/components/live_projects.dart' as _live_projects;
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
    _live_projects.LiveProjects: ClientTarget<_live_projects.LiveProjects>(
      'live_projects',
      params: __live_projectsLiveProjects,
    ),
  },
  styles: () => [..._styles.styles],
);

Map<String, Object?> __live_projectsLiveProjects(
  _live_projects.LiveProjects c,
) => {
  'repository': c.repository?.toJson(),
  'repositories': c.repositories?.map((i) => i.toJson()).toList(),
  'packages': c.packages?.map((i) => i.toJson()).toList(),
};
