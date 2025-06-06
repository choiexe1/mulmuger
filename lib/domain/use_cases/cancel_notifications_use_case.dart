import 'package:mulmuger/domain/repositories/local_push_repository.dart';

class CancelNotificationsUseCase {
  const CancelNotificationsUseCase(this._localPushRepository);

  final LocalPushRepository _localPushRepository;

  Future<void> execute() async {
    await _localPushRepository.cancelNotifications();
  }
}
