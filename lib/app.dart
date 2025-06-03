import 'package:flutter/material.dart';
import 'package:mulmuger/config/app_config.dart';
import 'package:mulmuger/core/router/app_router.dart';

class App extends StatelessWidget {
  const App({required AppRouter router, super.key}) : _router = router;

  final AppRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: _router.config(deepLinkBuilder: _router.deepLinkHandler),
    );
  }
}
