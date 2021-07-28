import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github/github.dart';
import 'package:rexios_dev/view/widgets/github_projects/github_info.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubProject extends StatelessWidget {
  final Repository repository;

  const GitHubProject({required this.repository});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: () => launch(repository.htmlUrl),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    repository.name,
                    style: Get.textTheme.bodyText2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  GitHubInfo(repository: repository),
                ],
              ),
              SizedBox(height: 10),
              Text(repository.description),
            ],
          ),
        ),
      ),
    );
  }
}
