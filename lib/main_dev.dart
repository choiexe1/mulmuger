import 'package:flutter/material.dart';
import 'package:mulmuger/app.dart';
import 'package:mulmuger/config/app_config.dart';
import 'package:mulmuger/core/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dependencyInjection();

  final appConfig = AppConfig.initialize(appName: '물머거', flavor: Flavor.dev);
  runApp(App(appConfig: appConfig));
}
