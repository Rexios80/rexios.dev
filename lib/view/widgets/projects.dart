import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rexios_dev/view/widgets/controllers/projects_controller.dart';
import 'package:rexios_dev/view/widgets/flutter_packages/flutter_packages.dart';
import 'package:rexios_dev/view/widgets/future_markdown.dart';
import 'package:rexios_dev/view/widgets/github_projects/github_info.dart';
import 'package:rexios_dev/view/widgets/github_projects/github_projects.dart';

class Projects extends StatelessWidget {
  final ProjectsController _controller = Get.find();

  Projects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'My Projects',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 40),
        Text(
          'Project Madad Maps (Flutter/Firebase)',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 20),
        const FutureMarkdown('assets/strings/pmm.txt'),
        const SizedBox(height: 20),
        Image.asset('assets/images/pmm.png'),
        const SizedBox(height: 80),
        Text(
          'Health Data Server (Flutter/Firebase/AWS/Swift)',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => GitHubInfo(
                repository: _controller.repoMap[ProjectsController.hdsSlug],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const FutureMarkdown('assets/strings/hds.txt'),
        const SizedBox(height: 20),
        Image.asset('assets/images/hds.gif'),
        const SizedBox(height: 80),
        Text(
          'Flutter Packages',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 20),
        FlutterPackages(),
        const SizedBox(height: 80),
        Text(
          'Other Projects',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 20),
        GitHubProjects(),
      ],
    );
  }
}
