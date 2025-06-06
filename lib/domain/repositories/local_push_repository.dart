import 'package:mulmuger/domain/entities/notification_entity.dart';
import 'package:mulmuger/domain/notification/notification_action.dart';

abstract interface class LocalPushRepository {
  Stream<NotificationAction> get notificationActionStream;

  Future<void> initialize();

  Future<void> immediatePush({
    required String title,
    required String body,
    required int id,
  });

  Future<void> durationPush({
    required String title,
    required String body,
    required Duration duration,
    required int id,
  });

  Future<void> scheduledPush({
    required String title,
    required String body,
    required int id,
  });

  Future<List<NotificationEntity>> findPendingNotifications();
  Future<void> cancelNotificationById(int id);
  Future<void> cancelNotifications();
}
