import 'package:flutter/material.dart';
import 'package:rexios_dev/view/widgets/future_markdown.dart';

class Bio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bio',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 20),
        FutureMarkdown('assets/strings/bio.txt'),
      ],
    );
  }
}
