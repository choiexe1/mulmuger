import 'package:flutter/material.dart';
import 'package:mulmuger/app.dart';
import 'package:mulmuger/core/router/app_router.dart';
import 'package:mulmuger/core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection();
  await sl.allReady();

  runApp(App(router: sl<AppRouter>()));
}
