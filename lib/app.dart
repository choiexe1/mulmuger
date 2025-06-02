import 'package:flutter/material.dart';
import 'package:mulmuger/core/app_router.dart';

class App extends StatelessWidget {
  const App({required AppRouter router, super.key}) : _router = router;

  final AppRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '물머거',
      debugShowCheckedModeBanner: false,
      routerConfig: _router.config(),
    );
  }
}
