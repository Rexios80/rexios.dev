import 'package:flutter/material.dart';
import 'package:rexios_dev/view/widgets/flutter_packages/flutter_packages.dart';
import 'package:rexios_dev/view/widgets/future_markdown.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'My Projects',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 40),
        Text(
          'Project Madad Maps (Flutter/Firebase)',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 20),
        FutureMarkdown('assets/strings/pmm.txt'),
        SizedBox(height: 20),
        Image.asset('assets/images/pmm.png'),
        SizedBox(height: 80),
        Text(
          'Health Data Server (Flutter/Firebase/AWS/Swift)',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 20),
        FutureMarkdown('assets/strings/hds.txt'),
        SizedBox(height: 20),
        Image.asset('assets/images/hds.gif'),
        SizedBox(height: 80),
        Text(
          'Flutter Packages',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 20),
        FlutterPackages(),
      ],
    );
  }
}
