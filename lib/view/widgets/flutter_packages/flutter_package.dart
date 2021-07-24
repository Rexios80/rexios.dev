import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rexios_dev/view/widgets/controllers/flutter_packages_controller.dart';
import 'package:rexios_dev/view/widgets/flutter_packages/flutter_package_score.dart';
import 'package:url_launcher/url_launcher.dart';

class FlutterPackage extends StatelessWidget {
  final PackageScoreInfo package;

  const FlutterPackage({required this.package});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: () => launch(package.info.url),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  package.info.name,
                  style: Get.textTheme.bodyText2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                FlutterPackageScore(package: package),
              ],
            ),
            SizedBox(height: 10),
            Text(package.info.description),
          ],
        ),
      ),
    );
  }
}
