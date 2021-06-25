import 'package:flutter/material.dart';
import 'package:rexios_dev/view/widgets/future_markdown.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        Row(
          children: [
            Expanded(
              child: FutureMarkdown('assets/strings/pmm.txt'),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Image.asset('assets/images/pmm.png'),
            ),
          ],
        ),
        SizedBox(height: 40),
        Text(
          'Health Data Server (Flutter/Firebase/AWS/Swift)',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: FutureMarkdown('assets/strings/hds.txt'),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Image.asset('assets/images/hds.gif'),
            ),
          ],
        ),
        SizedBox(height: 40),
        Text(
          'Polar Flutter Plugin (Flutter)',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 20),
        FutureMarkdown('assets/strings/polar.txt'),
      ],
    );
  }
}
