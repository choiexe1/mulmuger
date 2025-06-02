import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:mulmuger/config/local_notification.dart';
import 'package:mulmuger/core/app_router.dart';
import 'package:mulmuger/core/logger.dart';

final GetIt locator = GetIt.instance;

Future<void> injection() async {
  // APP CONFIG
  locator
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<Logger>(logger)
    ..registerSingleton<LocalNotification>(LocalNotification());
}
