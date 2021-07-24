import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rexios_dev/view/widgets/controllers/flutter_packages_controller.dart';
import 'package:rexios_dev/view/widgets/flutter_packages/flutter_package.dart';

class FlutterPackages extends StatelessWidget {
  final _controller = FlutterPackagesController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.packageScoreInfos.isNotEmpty
          ? Column(
              children: _controller.packageScoreInfos
                  .map((info) => FlutterPackage(package: info))
                  .toList(),
            )
          : Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'This doesn\'t like to work in Safari on the first page load.\n\nPlease refresh.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}
