import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SocialLink(
          icon: FaIcon(FontAwesomeIcons.discord),
          url: 'https://discord.gg/v5yAdrucdG',
        ),
        SocialLink(
          icon: MatrixIcon(),
          url: 'https://matrix.to/#/@rexios:mozilla.org',
        ),
        SocialLink(
          icon: FaIcon(FontAwesomeIcons.github),
          url: 'https://github.com/Rexios80',
        ),
        SocialLink(
          icon: FaIcon(FontAwesomeIcons.mastodon),
          url: 'https://mastodon.social/@Rexios',
        ),
      ],
    );
  }
}

class MatrixIcon extends StatelessWidget {
  const MatrixIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SvgPicture.asset(
        'assets/images/matrix.svg',
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class SocialLink extends StatelessWidget {
  final Widget icon;
  final String url;

  const SocialLink({
    super.key,
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      padding: EdgeInsets.zero,
      onPressed: () => launchUrlString(url),
    );
  }
}
