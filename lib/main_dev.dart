import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulmuger/app.dart';
import 'package:mulmuger/core/app_router.dart';
import 'package:mulmuger/core/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection();

  runApp(ProviderScope(child: App(router: locator<AppRouter>())));
}
