import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mulmuger/domain/entities/notification_entity.dart';

extension PendingNotificationMapper on PendingNotificationRequest {
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title ?? '',
      body: body ?? '',
      duration: Duration.zero,
      createdAt: DateTime.now(),
    );
  }
}
