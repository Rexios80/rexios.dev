import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SocialLink(
              icon: FontAwesomeIcons.discord,
              url: 'https://discord.gg/v5yAdrucdG',
            ),
            SocialLink(
              icon: FontAwesomeIcons.github,
              url: 'https://github.com/Rexios80',
            ),
            SocialLink(
              icon: FontAwesomeIcons.twitter,
              url: 'https://twitter.com/rexios85',
            ),
            SocialLink(
              icon: FontAwesomeIcons.youtube,
              url: 'https://www.youtube.com/channel/UCH09mEzK3Tec-yPKbbfQVhQ',
            ),
            SocialLink(
              icon: FontAwesomeIcons.twitch,
              url: 'https://twitch.tv/rexios85',
            ),
          ],
        ),
      ],
    );
  }
}

class SocialLink extends StatelessWidget {
  final IconData icon;
  final String url;

  const SocialLink({
    Key? key,
    required this.icon,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(icon),
      onPressed: () => launch(url),
    );
  }
}
