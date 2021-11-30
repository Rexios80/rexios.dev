import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rexios_dev/view/widgets/controllers/flutter_packages_controller.dart';
import 'package:rexios_dev/view/widgets/flutter_packages/flutter_package_score.dart';
import 'package:url_launcher/url_launcher.dart';

class FlutterPackage extends StatelessWidget {
  final PackageScoreInfo package;

  const FlutterPackage({required this.package, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: () => launch(package.info.url),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    package.info.name,
                    style: Get.textTheme.bodyText2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  FlutterPackageScore(package: package),
                ],
              ),
              const SizedBox(height: 10),
              Text(package.info.description),
            ],
          ),
        ),
      ),
    );
  }
}
