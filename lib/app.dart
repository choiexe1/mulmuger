import 'package:flutter/material.dart';
import 'package:mulmuger/config/app_config.dart';
import 'package:mulmuger/presentation/screens/home_screen.dart';

class App extends StatelessWidget {
  final AppConfig appConfig;
  const App({super.key, required this.appConfig});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appConfig.appName,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
