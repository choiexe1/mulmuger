import 'package:mulmuger/domain/services/local_push_service.dart';

class CancelNotificationsUseCase {
  const CancelNotificationsUseCase(this._notificationService);

  final LocalPushService _notificationService;

  Future<void> execute() async {
    await _notificationService.cancelNotifications();
  }
}
