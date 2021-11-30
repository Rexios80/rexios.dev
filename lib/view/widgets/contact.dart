import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:rexios_dev/app_icons.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Social Links',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            InkWell(
              onTap: () => launch('https://discord.gg/v5yAdrucdG'),
              child: const Icon(AppIcons.discord),
            ),
            const SizedBox(width: 15),
            InkWell(
              onTap: () => launch('https://github.com/Rexios80'),
              child: const Icon(AppIcons.github),
            ),
            const SizedBox(width: 15),
            InkWell(
              onTap: () => launch('https://twitter.com/rexios85'),
              child: const Icon(AppIcons.twitter),
            ),
            const SizedBox(width: 15),
            InkWell(
              onTap: () => launch(
                'https://www.youtube.com/channel/UCH09mEzK3Tec-yPKbbfQVhQ',
              ),
              child: const Icon(AppIcons.youtube),
            ),
            const SizedBox(width: 15),
            InkWell(
              onTap: () => launch('https://www.twitch.tv/rexios85'),
              child: const Icon(AppIcons.twitch),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
