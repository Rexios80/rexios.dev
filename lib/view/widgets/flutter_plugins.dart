import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rexios_dev/view/widgets/controllers/flutter_plugins_controller.dart';

class FlutterPlugins extends StatelessWidget {
  final _controller = FlutterPluginsController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: _controller.packageMetricsInfos.keys
            .map((info) => Text('test'))
            .toList(),
      ),
    );
  }
}
