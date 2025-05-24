import 'package:flutter/material.dart';
import 'package:mulmuger/app.dart';
import 'package:mulmuger/config/app_config.dart';

void main() {
  final AppConfig appConfig = AppConfig.initialize(
    appName: '물머거',
    flavor: Flavor.dev,
  );

  runApp(App(appConfig: appConfig));
}
