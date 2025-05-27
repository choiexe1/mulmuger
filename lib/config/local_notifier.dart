import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

enum NotificationLevel {
  immediate(0),
  scheduled(1),
  periodic(2);

  const NotificationLevel(this.id);

  final int id;
}

class LocalNotifier {
  static const String notificationIcon = '@mipmap/ic_launcher';
  static const String location = 'Asia/Seoul';
  final _notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(location));

    const androidSettings = AndroidInitializationSettings(notificationIcon);
    const initializeSetting = InitializationSettings(android: androidSettings);

    await _notificationPlugin.initialize(initializeSetting);
    _isInitialized = true;
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'mulmuger_channel_id',
        '물먹어 알림',
        channelDescription: '물먹어 알림 채널',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  Future<void> immediateNotification({
    NotificationLevel level = NotificationLevel.immediate,
    String? title,
    String? body,
  }) async {
    return _notificationPlugin.show(
      level.id,
      title,
      body,
      _notificationDetails(),
    );
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required int hour,
    required int minute,
    NotificationLevel level = NotificationLevel.scheduled,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    await _notificationPlugin.zonedSchedule(
      level.id,
      title,
      body,
      scheduledDate,
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> durationallyNotification({
    required String body,
    required Duration duration,
    NotificationLevel level = NotificationLevel.periodic,
    String? title,
  }) async {
    await cancelNotification(level);

    return _notificationPlugin.periodicallyShowWithDuration(
      level.id,
      '물먹어',
      body,
      duration,
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelNotification(NotificationLevel level) async {
    await _notificationPlugin.cancel(level.id);
  }

  Future<void> cancelAllNotifications() async {
    await _notificationPlugin.cancelAll();
  }
}
