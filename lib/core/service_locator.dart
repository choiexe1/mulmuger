import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:mulmuger/config/local_notification.dart';
import 'package:mulmuger/core/logger.dart';
import 'package:mulmuger/core/router/app_router.dart';
import 'package:mulmuger/data/services/flutter_local_notification_push_service.dart';
import 'package:mulmuger/domain/services/local_push_service.dart';
import 'package:mulmuger/domain/use_cases/cancel_notifications_use_case.dart';
import 'package:mulmuger/domain/use_cases/find_pending_notifications_use_case.dart';
import 'package:mulmuger/domain/use_cases/set_duration_push_use_case.dart';
import 'package:mulmuger/presentation/screens/home/home_view_model.dart';

final GetIt sl = GetIt.instance;

Future<void> injection() async {
  // ==========
  // APP CONFIG
  // ==========
  sl
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<Logger>(logger)
    ..registerSingleton<LocalNotification>(LocalNotification())
    // ========
    // SERVICES
    // ========
    ..registerLazySingleton<LocalPushService>(
      () => FlutterLocalNotificationPushService(
        plugin: FlutterLocalNotificationsPlugin(),
      )..initialize(),
    )
    // =========
    // USE CASES
    // =========
    ..registerLazySingleton<SetDurationPushUseCase>(
      () => SetDurationPushUseCase(sl()),
    )
    ..registerLazySingleton<CancelNotificationsUseCase>(
      () => CancelNotificationsUseCase(sl()),
    )
    ..registerLazySingleton<FindPendingNotificationsUseCase>(
      () => FindPendingNotificationsUseCase(sl()),
    )
    // ===========
    // VIEW MODELS
    // ===========
    ..registerFactory<HomeViewModel>(
      () => HomeViewModel(sl(), sl(), sl(), sl()),
    );
}
