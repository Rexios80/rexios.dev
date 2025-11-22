import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:rexios_dev/view/widget/github/github_project_info.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GitHubProject extends StatelessWidget {
  final Repository repository;

  const GitHubProject({required this.repository, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: () => launchUrlString(repository.htmlUrl),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    repository.name,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GitHubProjectInfo(repository: repository),
                ],
              ),
              const SizedBox(height: 10),
              Text(repository.description),
            ],
          ),
        ),
      ),
    );
  }
}
