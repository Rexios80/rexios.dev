import 'package:fast_ui/fast_ui.dart';
import 'package:flutter/material.dart';
import 'package:rexios_dev/controller/pub_controller.dart';
import 'package:rexios_dev/view/widget/pub/pub_package.dart';

class PubPackages extends StatelessWidget {
  final _controller = PubController();

  PubPackages({super.key});

  @override
  Widget build(BuildContext context) {
    return FastBuilder(
      () => _controller.packageScoreInfos.isNotEmpty
          ? Column(
              children: _controller.packageScoreInfos
                  .map((info) => PubPackage(package: info))
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
