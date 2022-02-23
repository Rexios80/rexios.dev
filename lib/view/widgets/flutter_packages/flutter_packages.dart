import 'package:fast_ui/fast_ui.dart';
import 'package:flutter/material.dart';
import 'package:rexios_dev/view/widgets/controllers/flutter_packages_controller.dart';
import 'package:rexios_dev/view/widgets/flutter_packages/flutter_package.dart';

class FlutterPackages extends StatelessWidget {
  final _controller = FlutterPackagesController();

  FlutterPackages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FastBuilder(
      () => _controller.packageScoreInfos.isNotEmpty
          ? Column(
              children: _controller.packageScoreInfos
                  .map((info) => FlutterPackage(package: info))
                  .toList(),
            )
          : Column(
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'This doesn\'t like to work in non Chromium based browsers',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}
