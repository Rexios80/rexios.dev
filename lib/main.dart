import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rexios_dev/view/widgets/bio.dart';
import 'package:rexios_dev/view/widgets/contact.dart';
import 'package:rexios_dev/view/widgets/controllers/github_controller.dart';
import 'package:rexios_dev/view/widgets/controllers/projects_controller.dart';
import 'package:rexios_dev/view/widgets/projects.dart';

void main() {
  Get.put(GithubController());
  Get.put(ProjectsController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics();

    return GetMaterialApp(
      title: 'Rexios',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      themeMode: ThemeMode.dark,
      home: const Launchpad(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
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
                  const Bio(),
                  const SizedBox(height: 80),
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
