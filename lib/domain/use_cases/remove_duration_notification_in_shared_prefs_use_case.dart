import 'package:mulmuger/domain/enums/notification_type.dart';
import 'package:mulmuger/domain/repositories/shared_prefs_local_repository.dart';

class RemoveDurationNotificationInSharedPrefsUseCase {
  const RemoveDurationNotificationInSharedPrefsUseCase(this._repository);

  final SharedPrefsLocalRepository _repository;

  Future<void> execute() async {
    await _repository.remove(NotificationType.duration.id.toString());
  }
}
