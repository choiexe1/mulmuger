import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mulmuger/config/notification_config.dart';
import 'package:mulmuger/data/mappers/pending_notification_mapper.dart';
import 'package:mulmuger/domain/entities/notification_entity.dart';
import 'package:mulmuger/domain/services/local_push_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class FlutterLocalNotificationPushService implements LocalPushService {
  FlutterLocalNotificationPushService({
    required FlutterLocalNotificationsPlugin plugin,
  }) : _plugin = plugin;

  final FlutterLocalNotificationsPlugin _plugin;
  bool _isInitialized = false;
  final String notificationIcon = '@mipmap/ic_launcher';
  final String timezone = 'Asia/Seoul';

  bool get isInitialized => _isInitialized;

  void _initializeChecker() {
    if (!isInitialized) {
      throw Exception('initialize() 메서드를 호출하여 초기화 후 사용해야합니다.');
    }
  }

  @override
  Future<void> initialize() async {
    if (isInitialized) {
      throw Exception('이미 초기화 되었습니다.');
    }

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(timezone));

    final androidSettings = AndroidInitializationSettings(notificationIcon);
    final initializeSetting = InitializationSettings(android: androidSettings);

    await _plugin.initialize(
      initializeSetting,
      onDidReceiveNotificationResponse: (NotificationResponse res) {},
      // onDidReceiveBackgroundNotificationResponse: () {},
    );

    _isInitialized = true;
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        NotificationConfig.channelId,
        NotificationConfig.channelName,
        importance: Importance.max,
        priority: Priority.high,
        actions: [AndroidNotificationAction('id_1', '물먹었다 체크하기')],
      ),
    );
  }

  @override
  Future<void> durationPush({
    required String title,
    required String body,
    required Duration duration,
    required int id,
  }) async {
    _initializeChecker();

    await _plugin.periodicallyShowWithDuration(
      id,
      title,
      body,
      duration,
      payload: '$duration 마다 알림',
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  @override
  Future<List<NotificationEntity>> findPendingNotifications() async {
    _initializeChecker();
    final notifications = await _plugin.pendingNotificationRequests();
    return notifications.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> immediatePush({
    required String title,
    required String body,
    required int id,
  }) async {
    _initializeChecker();
    await _plugin.show(id, title, body, _notificationDetails());
  }

  @override
  Future<void> cancelNotificationById(int id) async {
    _initializeChecker();
    await _plugin.cancel(id);
  }

  @override
  Future<void> cancelNotifications() async {
    _initializeChecker();
    await _plugin.cancelAll();
  }

  @override
  Future<void> scheduledPush({
    required String title,
    required String body,
    required int id,
  }) async {
    throw UnimplementedError();
    // final now = tz.TZDateTime.now(tz.local);

    // final scheduledDate = tz.TZDateTime(
    //   tz.local,
    //   now.year,
    //   now.month,
    //   now.day,
    //   hour,
    //   minute,
    // );

    // await _notificationPlugin.zonedSchedule(
    //   level.id,
    //   title,
    //   body,
    //   scheduledDate,
    //   _notificationDetails(),
    //   androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    // );
  }
}
