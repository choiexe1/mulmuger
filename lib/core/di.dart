import 'package:get_it/get_it.dart';
import 'package:mulmuger/config/local_notifier.dart';
import 'package:mulmuger/core/app_router.dart';
// import 'package:mulmuger/core/app_router.dart';
import 'package:mulmuger/presentation/screens/home_view_model.dart';

extension GetItExtension on GetIt {
  Future<void> injection() async {
    this
      ..registerSingleton<AppRouter>(AppRouter())
      ..registerSingleton<LocalNotifier>(LocalNotifier())
      ..registerFactory<HomeViewModel>(
        () => HomeViewModel(this<LocalNotifier>()),
      );
  }
}
