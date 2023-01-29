import 'package:flutter/material.dart';
import 'package:rexios_dev/model/package_score_info.dart';
import 'package:rexios_dev/view/widget/pub/pub_package_score.dart';
import 'package:fast_ui/fast_ui.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PubPackage extends StatelessWidget {
  final PackageScoreInfo package;

  const PubPackage({required this.package, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: () => launchUrlString(package.info.url),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    package.info.name,
                    style: context.textTheme.bodyMedium!
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
