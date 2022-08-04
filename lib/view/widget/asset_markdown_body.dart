import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AssetMarkdownBody extends StatelessWidget {
  final String asset;

  const AssetMarkdownBody(this.asset, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString(asset),
      builder: (context, snap) => MarkdownBody(
        data: snap.data ?? '',
        onTapLink: (text, href, title) => launchUrlString(href ?? ''),
      ),
    );
  }
}
