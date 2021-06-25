import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_icons.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Social Links',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(),
            InkWell(
              onTap: () => launch('https://discord.gg/v5yAdrucdG'),
              child: Icon(AppIcons.discord),
            ),
            SizedBox(width: 15),
            InkWell(
              onTap: () => launch('https://github.com/Rexios80'),
              child: Icon(AppIcons.github),
            ),
            SizedBox(width: 15),
            InkWell(
              onTap: () => launch('https://twitter.com/rexios85'),
              child: Icon(AppIcons.twitter),
            ),
            SizedBox(width: 15),
            InkWell(
              onTap: () => launch(
                  'https://www.youtube.com/channel/UCH09mEzK3Tec-yPKbbfQVhQ'),
              child: Icon(AppIcons.youtube),
            ),
            SizedBox(width: 15),
            InkWell(
              onTap: () => launch('https://www.twitch.tv/rexios85'),
              child: Icon(AppIcons.twitch),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
