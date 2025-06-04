import 'package:mulmuger/domain/entities/notification_entity.dart';

abstract interface class LocalPushService {
  Future<void> initialize();
  Future<void> immediatePush({
    required String title,
    required String body,
    required int id,
  });
  Future<void> scheduledPush({
    required String title,
    required String body,
    required int id,
  });
  Future<void> durationPush({
    required Duration duration,
    required String title,
    required String body,
    required int id,
  });
  Future<void> cancelNotificationById(int id);
  Future<void> cancelNotifications();
  Future<List<NotificationEntity>> findPendingNotifications();
}
