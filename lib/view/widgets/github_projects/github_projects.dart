import 'package:fast_ui/fast_ui.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rexios_dev/controllers/projects_controller.dart';
import 'package:rexios_dev/view/widgets/github_projects/github_project.dart';

class GitHubProjects extends StatelessWidget {
  final _controller = GetIt.I<ProjectsController>();

  GitHubProjects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FastBuilder(
      () => _controller.otherRepos.isNotEmpty
          ? Column(
              children: _controller.otherRepos
                  .map((repository) => GitHubProject(repository: repository))
                  .toList(),
            )
          : const CircularProgressIndicator(),
    );
  }
}
