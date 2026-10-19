// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:rexios_dev/components/live_projects.dart'
    deferred as _live_projects;
import 'package:rexios_dev/data/models.dart' as _models;

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
    'live_projects': ClientLoader(
      (p) => _live_projects.LiveProjects(
        repository: p['repository'] != null
            ? _models.RepoInfo.fromJson(p['repository'] as Map<String, dynamic>)
            : null,
        repositories: (p['repositories'] as List<Object?>?)
            ?.map((i) => _models.RepoInfo.fromJson(i as Map<String, dynamic>))
            .toList(),
        packages: (p['packages'] as List<Object?>?)
            ?.map(
              (i) => _models.PackageInfo.fromJson(i as Map<String, dynamic>),
            )
            .toList(),
      ),
      loader: _live_projects.loadLibrary,
    ),
  },
);
