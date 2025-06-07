import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mulmuger/app.dart';
import 'package:mulmuger/config/app_config.dart';
import 'package:mulmuger/config/flavor.dart';
import 'package:mulmuger/core/router/app_router.dart';
import 'package:mulmuger/core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await MobileAds.instance.initialize();

  await injection(Flavor.prod);
  await sl.allReady();

  runApp(App(router: sl<AppRouter>(), config: sl<AppConfig>()));
}
