import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rexios',
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
  const Launchpad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        title: const Text('Rexios'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  Projects(),
                  const SizedBox(height: 80),
                  const Contact(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
