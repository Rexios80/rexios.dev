import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rexios_dev/view/widgets/bio.dart';
import 'package:rexios_dev/view/widgets/contact.dart';
import 'package:rexios_dev/view/widgets/controllers/github_controller.dart';
import 'package:rexios_dev/view/widgets/projects.dart';

void main() {
  Get.put(GithubController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: Launchpad(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}

class Launchpad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        title: Text('Rexios'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  Bio(),
                  SizedBox(height: 80),
                  Projects(),
                  SizedBox(height: 80),
                  Contact(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
