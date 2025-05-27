import 'package:get_it/get_it.dart';
import 'package:mulmuger/config/local_notifier.dart';

final sl = GetIt.instance;

void dependencyInjection() {
  // Core
  sl.registerSingletonAsync<LocalNotifier>(() async {
    final localNotifer = LocalNotifier();
    await localNotifer.initialize();
    return localNotifer;
  });
}
