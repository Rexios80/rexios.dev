import 'package:flutter/material.dart';
import 'package:rexios_dev/view/widgets/future_markdown.dart';

class Bio extends StatelessWidget {
  const Bio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bio',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 20),
        const FutureMarkdown('assets/strings/bio.txt'),
      ],
    );
  }
}
