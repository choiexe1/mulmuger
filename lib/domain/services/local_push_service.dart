import 'package:mulmuger/domain/entities/notification_entity.dart';

abstract interface class LocalPushService {
  Future<void> initialize();
  Future<void> immediatePush({int? id, String? title, String? body});
  Future<void> scheduledPush({int? id, String? title, String? body});
  Future<void> durationPush({required Duration duration, String? body});
  Future<void> cancelNotificationById(int id);
  Future<void> cancelNotifications();
  Future<List<NotificationEntity>> findPendingNotifications();
}
