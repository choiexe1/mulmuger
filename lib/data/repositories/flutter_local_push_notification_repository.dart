import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mulmuger/config/notification_config.dart';
import 'package:mulmuger/data/mappers/pending_notification_mapper.dart';
import 'package:mulmuger/domain/entities/notification_entity.dart';
import 'package:mulmuger/domain/notification/notification_action.dart';
import 'package:mulmuger/domain/repositories/local_push_repository.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const String _notificationCancel = 'notification_cancel';
const String _mainIsolatePortName = 'main_isolate_port';

@pragma('vm:entry-point')
void backgroundNotificationHandler(NotificationResponse res) {
  final mainSendPort = IsolateNameServer.lookupPortByName(_mainIsolatePortName);

  if (mainSendPort == null) {
    throw Exception('백그라운드: 메인 Isolate의 SendPort를 찾을 수 없습니다.');
  }

  if (res.actionId == _notificationCancel) {
    mainSendPort.send(_notificationCancel);
  }
}

class FlutterLocalPushNotificationRepository implements LocalPushRepository {
  FlutterLocalPushNotificationRepository(this._plugin) {
    initialize();
  }

  final FlutterLocalNotificationsPlugin _plugin;
  final _actionStreamController =
      StreamController<NotificationAction>.broadcast();
  final ReceivePort _receivePort = ReceivePort();

  @override
  Stream<NotificationAction> get notificationActionStream =>
      _actionStreamController.stream;

  @override
  Future<void> initialize() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

    IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      _mainIsolatePortName,
    );
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initializeSetting = InitializationSettings(android: androidSettings);

    await _plugin.initialize(
      initializeSetting,
      onDidReceiveNotificationResponse: (NotificationResponse res) {
        switch (res.actionId) {
          case _notificationCancel:
            _actionStreamController.add(NotificationAction.cancel());
          default:
            _actionStreamController.add(
              NotificationAction.addWater(NotificationConfig.defaultAddWater),
            );
        }
      },
      onDidReceiveBackgroundNotificationResponse: backgroundNotificationHandler,
    );

    _receivePort.listen((message) {
      if (message == _notificationCancel) {
        _actionStreamController.add(NotificationAction.cancel());
      }
    });
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        NotificationConfig.channelId,
        NotificationConfig.channelName,
        importance: Importance.max,
        priority: Priority.high,
        actions: [AndroidNotificationAction(_notificationCancel, '알람 끄기')],
      ),
    );
  }

  @override
  Future<void> cancelNotificationById(int id) async {
    await _plugin.cancel(id);
  }

  @override
  Future<void> cancelNotifications() async {
    await _plugin.cancelAll();
  }

  @override
  Future<void> durationPush({
    required String title,
    required String body,
    required Duration duration,
    required int id,
  }) async {
    await _plugin.periodicallyShowWithDuration(
      id,
      title,
      body,
      duration,
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  @override
  Future<List<NotificationEntity>> findPendingNotifications() async {
    final notifications = await _plugin.pendingNotificationRequests();
    return notifications.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> immediatePush({
    required String title,
    required String body,
    required int id,
  }) async {
    await _plugin.show(id, title, body, _notificationDetails());
  }

  @override
  Future<void> scheduledPush({
    required String title,
    required String body,
    required int id,
  }) {
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
