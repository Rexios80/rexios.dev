import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
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
    );
  }
}

class SocialLink extends StatelessWidget {
  final IconData icon;
  final String url;

  const SocialLink({
    super.key,
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(icon),
      padding: EdgeInsets.zero,
      onPressed: () => launchUrlString(url),
    );
  }
}
