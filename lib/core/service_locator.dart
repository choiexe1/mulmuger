import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:mulmuger/core/logger.dart';
import 'package:mulmuger/core/router/app_router.dart';
import 'package:mulmuger/data/repositories/shared_prefs_local_repository_impl.dart';
import 'package:mulmuger/data/services/flutter_local_notification_push_service.dart';
import 'package:mulmuger/data/services/permission_handler_service.dart';
import 'package:mulmuger/domain/repositories/shared_prefs_local_repository.dart';
import 'package:mulmuger/domain/services/local_push_service.dart';
import 'package:mulmuger/domain/services/permission_service.dart';
import 'package:mulmuger/domain/use_cases/cancel_notifications_use_case.dart';
import 'package:mulmuger/domain/use_cases/check_permission_use_case.dart';
import 'package:mulmuger/domain/use_cases/find_pending_notifications_use_case.dart';
import 'package:mulmuger/domain/use_cases/get_duration_notification_use_case.dart';
import 'package:mulmuger/domain/use_cases/remove_duration_notification_in_shared_prefs_use_case.dart';
import 'package:mulmuger/domain/use_cases/save_duration_notification_use_case.dart';
import 'package:mulmuger/domain/use_cases/set_duration_push_use_case.dart';
import 'package:mulmuger/presentation/screens/home/home_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> injection() async {
  // ==========
  // APP CONFIG
  // ==========
  sl
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<Logger>(logger)
    ..registerSingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance(),
    )
    // ============
    // REPOSIRORIES
    // ============
    ..registerLazySingleton<SharedPrefsLocalRepository>(
      () => SharedPrefsLocalRepositoryImpl(sl()),
    )
    // ========
    // SERVICES
    // ========
    ..registerLazySingleton<LocalPushService>(
      () => FlutterLocalNotificationPushService(
        plugin: FlutterLocalNotificationsPlugin(),
      )..initialize(),
    )
    ..registerLazySingleton<PermissionService>(PermissionHandlerService.new)
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
    ..registerLazySingleton<CheckPermissionUseCase>(
      () => CheckPermissionUseCase(sl()),
    )
    ..registerLazySingleton<SaveDurationNotificationUseCase>(
      () => SaveDurationNotificationUseCase(sl()),
    )
    ..registerLazySingleton<GetDurationNotificationUseCase>(
      () => GetDurationNotificationUseCase(sl()),
    )
    ..registerLazySingleton<RemoveDurationNotificationInSharedPrefsUseCase>(
      () => RemoveDurationNotificationInSharedPrefsUseCase(sl()),
    )
    // ===========
    // VIEW MODELS
    // ===========
    ..registerFactory<HomeViewModel>(
      () => HomeViewModel(sl(), sl(), sl(), sl(), sl(), sl(), sl()),
    );
}
