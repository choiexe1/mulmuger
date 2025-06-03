import 'package:mulmuger/domain/entities/notification_entity.dart';
import 'package:mulmuger/domain/services/local_push_service.dart';

class FindPendingNotificationsUseCase {
  const FindPendingNotificationsUseCase(this._notificationService);

  final LocalPushService _notificationService;

  Future<List<NotificationEntity>> execute() async {
    return _notificationService.findPendingNotifications();
  }
}
