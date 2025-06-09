import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mulmuger/config/notification_config.dart';
import 'package:mulmuger/domain/entities/notification_entity.dart';
import 'package:mulmuger/domain/enums/notification_type.dart';
import 'package:mulmuger/domain/enums/permission_type.dart';
import 'package:mulmuger/domain/notification/notification_action.dart';
import 'package:mulmuger/domain/use_cases/cancel_notifications_use_case.dart';
import 'package:mulmuger/domain/use_cases/check_permission_use_case.dart';
import 'package:mulmuger/domain/use_cases/clear_water_use_case.dart';
import 'package:mulmuger/domain/use_cases/get_duration_notification_use_case.dart';
import 'package:mulmuger/domain/use_cases/listen_notification_action_stream_use_case.dart.dart';
import 'package:mulmuger/domain/use_cases/load_current_water_use_case.dart';
import 'package:mulmuger/domain/use_cases/remove_duration_notification_in_shared_prefs_use_case.dart';
import 'package:mulmuger/domain/use_cases/save_currnet_water_use_case.dart';
import 'package:mulmuger/domain/use_cases/save_duration_notification_use_case.dart';
import 'package:mulmuger/domain/use_cases/set_duration_push_use_case.dart';
import 'package:mulmuger/presentation/screens/home/home_action.dart';
import 'package:mulmuger/presentation/screens/home/home_state.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel(
    this._logger,
    this._setDurationPushUseCase,
    this._cancelNotificationsUseCase,
    this._checkPermissionUseCase,
    this._saveDurationNotificationUseCase,
    this._getDurationNotificationUseCase,
    this._removeDurationNotificationInSharedPrefsUseCase,
    this._listenNotificationActionStreamUseCase,
    this._saveCurrentWaterUseCase,
    this._loadCurrentWaterUseCase,
    this._clearWaterUseCase,
  ) {
    _notificationSubscription = _listenNotificationActionStreamUseCase
        .execute()
        .listen((action) {
          switch (action) {
            case Cancel():
              _cancelNotifications();
            case AddWater(:final double value):
              _addWater(value);
          }
        });
  }

  HomeState _state = const HomeState();

  final Logger _logger;

  final SetDurationPushUseCase _setDurationPushUseCase;
  final CancelNotificationsUseCase _cancelNotificationsUseCase;
  final CheckPermissionUseCase _checkPermissionUseCase;
  final SaveDurationNotificationUseCase _saveDurationNotificationUseCase;
  final GetDurationNotificationUseCase _getDurationNotificationUseCase;
  final RemoveDurationNotificationInSharedPrefsUseCase
  _removeDurationNotificationInSharedPrefsUseCase;
  final ListenNotificationActionStreamUseCase
  _listenNotificationActionStreamUseCase;
  final SaveCurrentWaterUseCase _saveCurrentWaterUseCase;
  final LoadCurrentWaterUseCase _loadCurrentWaterUseCase;
  final ClearWaterUseCase _clearWaterUseCase;

  StreamSubscription<NotificationAction>? _notificationSubscription;

  HomeState get state => _state;

  Future<void> onAction(HomeAction action) async {
    switch (action) {
      case OnChangedDuration(:final Duration duration):
        await _setDurationPush(duration);
      case CheckNotifications():
        await _findPendingNotifications();
      case CancelNotifications():
        await _cancelNotifications();
      case ClearWater():
        await _clearWater();
    }
  }

  Future<void> init() async {
    await _checkPermissionUseCase.execute(PermissionType.notification);

    final notificationEntity = await _getDurationNotificationUseCase.execute();
    final water = await _loadCurrentWaterUseCase.execute();

    _state = _state.copyWith(water: water);

    if (notificationEntity != null) {
      _state = _state.copyWith(
        duration: notificationEntity.duration,
        message: '${notificationEntity.duration.inMinutes}분마다 알람이 울릴거에요!',
      );
    }

    notifyListeners();
  }

  Future<void> _setDurationPush(Duration duration) async {
    await _setDurationPushUseCase.execute(
      id: NotificationType.duration.id,
      title: NotificationConfig.title,
      body: NotificationConfig.defaultMessage,
      duration: duration,
    );

    final entity = NotificationEntity.fromNow(
      id: NotificationType.duration.id,
      title: NotificationConfig.title,
      body: NotificationConfig.defaultMessage,
      duration: duration,
    );

    await _saveDurationNotificationUseCase.execute(entity);

    _state = state.copyWith(
      duration: duration,
      message: '${entity.duration.inMinutes}분마다 알람이 울릴거에요!',
    );

    notifyListeners();
  }

  Future<void> _findPendingNotifications() async {
    final notification = await _getDurationNotificationUseCase.execute();
    _logger.d(notification);
  }

  Future<void> _cancelNotifications() async {
    await _cancelNotificationsUseCase.execute();
    await _removeDurationNotificationInSharedPrefsUseCase.execute();
    _state = _state.copyWith(
      duration: Duration.zero,
      message: '현재 설정된 알람이 없어요!',
    );
    notifyListeners();
  }

  Future<void> _addWater(double value) async {
    final currentWater = await _loadCurrentWaterUseCase.execute();

    _state = _state.copyWith(water: currentWater + value);
    await _saveCurrentWaterUseCase.execute(_state.water);

    notifyListeners();
  }

  Future<void> _clearWater() async {
    await _clearWaterUseCase.execute();

    _state = _state.copyWith(water: 0);

    notifyListeners();
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    super.dispose();
  }
}
