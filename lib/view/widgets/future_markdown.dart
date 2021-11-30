import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class FutureMarkdown extends StatelessWidget {
  final String asset;

  const FutureMarkdown(this.asset, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString(asset),
      builder: (context, snap) => MarkdownBody(
        data: snap.data ?? '',
        onTapLink: (text, href, title) => launch(href ?? ''),
      ),
    );
  }
}
