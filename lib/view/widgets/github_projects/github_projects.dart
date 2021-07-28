import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rexios_dev/view/widgets/controllers/projects_controller.dart';
import 'package:rexios_dev/view/widgets/github_projects/github_project.dart';

class GitHubProjects extends StatelessWidget {
  final ProjectsController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.otherRepos.isNotEmpty
          ? Column(
              children: _controller.otherRepos
                  .map((repository) => GitHubProject(repository: repository))
                  .toList(),
            )
          : CircularProgressIndicator(),
    );
  }
}
