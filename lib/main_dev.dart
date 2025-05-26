import 'package:flutter/material.dart';
import 'package:mulmuger/app.dart';
import 'package:mulmuger/config/app_config.dart';
import 'package:mulmuger/config/local_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localNotifier = LocalNotifier();
  await localNotifier.initNotification();

  final appConfig = AppConfig.initialize(appName: '물머거', flavor: Flavor.dev);

  runApp(App(appConfig: appConfig));
}
