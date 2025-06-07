import 'package:flutter/material.dart';
import 'package:mulmuger/config/app_config.dart';
import 'package:mulmuger/core/router/app_router.dart';

class App extends StatelessWidget {
  const App({required AppRouter router, required AppConfig config, super.key})
    : _router = router,
      _config = config;

  final AppRouter _router;
  final AppConfig _config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: _config.title,
      debugShowCheckedModeBanner: false,
      routerConfig: _router.config(deepLinkBuilder: _router.deepLinkHandler),
    );
  }
}
