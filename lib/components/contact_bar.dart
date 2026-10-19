import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:rexios_dev/data/models.dart';

class ContactBar extends StatelessComponent {
  const ContactBar({required this.profiles, super.key});

  final ProfileStats profiles;

  @override
  Component build(BuildContext context) {
    final github = profiles.github;
    final x = profiles.x;
    final discord = profiles.discord;
    return nav(classes: 'contact-bar', attributes: {'aria-label': 'Contact'}, [
      ContactCard(
        href: github.href,
        label: '${github.login}, ${github.followers} followers',
        name: github.login,
        icon: const BrandIcon([_githubPath], viewBox: '0 0.297 24 23.406'),
        stats: [
          [
            const StatIcon(_followersPath),
            .text('${github.followers} followers'),
          ],
        ],
      ),
      const ContactCard(
        href: 'https://www.linkedin.com/in/aaron-delory',
        label: 'aaron-delory on LinkedIn',
        name: 'aaron-delory',
        icon: BrandIcon([_linkedinPath], viewBox: '0 1 22.56 23'),
        stats: [],
      ),
      ContactCard(
        href: x.href,
        label: '${x.screenName}, ${x.followers} followers',
        name: x.screenName,
        icon: const BrandIcon([_xPath], viewBox: '0.258 0 23.484 24'),
        stats: [
          [
            const StatIcon(_followersPath),
            .text('${x.followers} followers'),
          ],
        ],
      ),
      DiscordCard(
        href: discord.href,
        name: discord.name,
        online: discord.online,
        members: discord.members,
      ),
    ]);
  }
}

@client
class DiscordCard extends StatefulComponent {
  const DiscordCard({required this.href, required this.name, required this.online, required this.members, super.key});

  final String href;
  final String name;
  final int online;
  final int members;

  @override
  State<DiscordCard> createState() => _DiscordCardState();
}

class _DiscordCardState extends State<DiscordCard> {
  late int _online;
  late int _members;

  @override
  void initState() {
    super.initState();
    _online = component.online;
    _members = component.members;
    if (kIsWeb) unawaited(_refresh());
  }

  Future<void> _refresh() async {
    try {
      final response = await http.get(
        Uri.https('discord.com', '/api/v10/invites/$_discordInvite', {'with_counts': 'true'}),
      );
      if (response.statusCode != 200 || !mounted) return;
      final data = jsonDecode(response.body);
      if (data is! Map) return;
      final online = data['approximate_presence_count'];
      final members = data['approximate_member_count'];
      if (online is! int || members is! int || !mounted) return;
      setState(() {
        _online = online;
        _members = members;
      });
    } on Object {
      // Keep the counts written at build time.
    }
  }

  @override
  Component build(BuildContext context) {
    return ContactCard(
      href: component.href,
      label: '${component.name}, $_online online, $_members members',
      name: component.name,
      icon: const BrandIcon([_discordPath], viewBox: '0 2.853 24 18.293'),
      stats: [
        [
          span(classes: 'presence', attributes: {'aria-hidden': 'true'}, []),
          .text('$_online'),
        ],
        [
          span(classes: 'presence members', attributes: {'aria-hidden': 'true'}, []),
          .text('$_members'),
        ],
      ],
    );
  }
}

class ContactCard extends StatelessComponent {
  const ContactCard({
    required this.href,
    required this.label,
    required this.name,
    required this.icon,
    required this.stats,
    super.key,
  });

  final String href;
  final String label;
  final String name;
  final Component icon;
  final List<List<Component>> stats;

  @override
  Component build(BuildContext context) {
    return a(
      classes: 'contact-card',
      href: href,
      target: .blank,
      referrerPolicy: .noReferrer,
      attributes: {'aria-label': label, 'rel': 'noopener noreferrer'},
      [
        icon,
        span(classes: 'contact-copy', [
          span(classes: 'contact-name', [.text(name)]),
          if (stats.isNotEmpty)
            span(classes: 'contact-stats', [
              for (final stat in stats) span(classes: 'contact-stat', stat),
            ]),
        ]),
      ],
    );
  }
}

class StatIcon extends StatelessComponent {
  const StatIcon(this.paths, {super.key});

  final List<String> paths;

  @override
  Component build(BuildContext context) {
    return svg(
      classes: 'stat-icon',
      viewBox: '0 0 24 24',
      width: 12.px,
      height: 12.px,
      attributes: {
        'aria-hidden': 'true',
        'focusable': 'false',
        'fill': 'none',
        'stroke': 'currentColor',
        'stroke-width': '2',
        'stroke-linecap': 'round',
        'stroke-linejoin': 'round',
      },
      [for (final pathData in paths) path(d: pathData, [])],
    );
  }
}

class BrandIcon extends StatelessComponent {
  const BrandIcon(this.paths, {this.viewBox = '0 0 24 24', super.key});

  final List<String> paths;
  final String viewBox;

  @override
  Component build(BuildContext context) {
    return svg(
      classes: 'brand-icon',
      viewBox: viewBox,
      attributes: {'aria-hidden': 'true', 'focusable': 'false'},
      [for (final pathData in paths) path(d: pathData, [])],
    );
  }
}

const _discordInvite = 'v5yAdrucdG';

const _followersPath = [
  'M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2',
  'M16 3.128a4 4 0 0 1 0 7.744',
  'M22 21v-2a4 4 0 0 0-3-3.87',
  'M13 7a4 4 0 1 0-8 0 4 4 0 0 0 8 0',
];

const _discordPath =
    'M20.317 4.3698a19.7913 19.7913 0 00-4.8851-1.5152.0741.0741 0 00-.0785.0371c-.211.3753-.4447.8648-.6083 1.2495-1.8447-.2762-3.68-.2762-5.4868 0-.1636-.3933-.4058-.8742-.6177-1.2495a.077.077 0 00-.0785-.037 19.7363 19.7363 0 00-4.8852 1.515.0699.0699 0 00-.0321.0277C.5334 9.0458-.319 13.5799.0992 18.0578a.0824.0824 0 00.0312.0561c2.0528 1.5076 4.0413 2.4228 5.9929 3.0294a.0777.0777 0 00.0842-.0276c.4616-.6304.8731-1.2952 1.226-1.9942a.076.076 0 00-.0416-.1057c-.6528-.2476-1.2743-.5495-1.8722-.8923a.077.077 0 01-.0076-.1277c.1258-.0943.2517-.1923.3718-.2914a.0743.0743 0 01.0776-.0105c3.9278 1.7933 8.18 1.7933 12.0614 0a.0739.0739 0 01.0785.0095c.1202.099.246.1981.3728.2924a.077.077 0 01-.0066.1276 12.2986 12.2986 0 01-1.873.8914.0766.0766 0 00-.0407.1067c.3604.698.7719 1.3628 1.225 1.9932a.076.076 0 00.0842.0286c1.961-.6067 3.9495-1.5219 6.0023-3.0294a.077.077 0 00.0313-.0552c.5004-5.177-.8382-9.6739-3.5485-13.6604a.061.061 0 00-.0312-.0286zM8.02 15.3312c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9555-2.4189 2.157-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.9555 2.4189-2.1569 2.4189zm7.9748 0c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9554-2.4189 2.1569-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.946 2.4189-2.1568 2.4189Z';

const _githubPath =
    'M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12';

const _linkedinPath =
    'M4.98 3.5C4.98 4.88 3.88 6 2.5 6S0 4.88 0 3.5 1.12 1 2.5 1 4.98 2.12 4.98 3.5zM.22 8.5h4.56V24H.22V8.5zM8.34 8.5h4.37v2.12h.06c.61-1.16 2.1-2.38 4.32-2.38 4.62 0 5.47 3.04 5.47 7v8.76h-4.56v-7.77c0-1.85-.03-4.23-2.58-4.23-2.58 0-2.97 2.01-2.97 4.1V24H8.34V8.5z';

const _xPath =
    'M14.234 10.162 22.977 0h-2.072l-7.591 8.824L7.251 0H.258l9.168 13.343L.258 24H2.33l8.016-9.318L16.749 24h6.993zm-2.837 3.299-.929-1.329L3.076 1.56h3.182l5.965 8.532.929 1.329 7.754 11.09h-3.182z';
