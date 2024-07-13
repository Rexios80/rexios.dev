import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:platform_plus/platform_plus.dart';
import 'package:rexios_dev/controller/github_controller.dart';
import 'package:rexios_dev/firebase_options.dart';
import 'package:rexios_dev/service/github_service.dart';
import 'package:rexios_dev/view/widget/projects.dart';
import 'package:rexios_dev/view/widget/contact.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingleton(GitHubService());
  GetIt.I.registerSingleton(GitHubController());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final analytics = FirebaseAnalytics.instance;
  await analytics.logAppOpen();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      themeMode: ThemeMode.dark,
      home: const Launchpad(),
    );
  }
}

class Launchpad extends StatelessWidget {
  const Launchpad({super.key});

  @override
  Widget build(BuildContext context) {
    final rendererString = PlatformPlus.platform.webRenderer.name.toUpperCase();

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            // Fix for erratic scroll bar behavior
            // See https://github.com/flutter/flutter/issues/25652#issuecomment-2199882727
            cacheExtent: 10000,
            padding: const EdgeInsets.only(
              top: 40,
              bottom: 74, // 24 + 5 + 5 + 40
              left: 20,
              right: 20,
            ),
            children: [
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Projects(),
                ),
              ),
              const SizedBox(height: 32),
              Center(child: Text('Rendered with $rendererString')),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: Colors.black,
              elevation: 4,
              shadowColor: Colors.white,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Contact(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
