import 'package:flutter/material.dart';
import 'package:rexios_dev/model/package_score_info.dart';
import 'package:rexios_dev/view/widget/pub/pub_package_score.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fast_ui/fast_ui.dart';

class PubPackage extends StatelessWidget {
  final PackageScoreInfo package;

  const PubPackage({required this.package, Key? key}) : super(key: key);

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
                    style: context.textTheme.bodyText2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  PubPackageScore(package: package),
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
