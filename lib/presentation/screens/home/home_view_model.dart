import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mulmuger/config/notification_config.dart';
import 'package:mulmuger/domain/entities/notification_entity.dart';
import 'package:mulmuger/domain/enums/notification_type.dart';
import 'package:mulmuger/domain/enums/permission_type.dart';
import 'package:mulmuger/domain/use_cases/cancel_notifications_use_case.dart';
import 'package:mulmuger/domain/use_cases/check_permission_use_case.dart';
import 'package:mulmuger/domain/use_cases/get_duration_notification_use_case.dart';
import 'package:mulmuger/domain/use_cases/remove_duration_notification_in_shared_prefs_use_case.dart';
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
  );

  HomeState _state = const HomeState();

  final Logger _logger;

  final SetDurationPushUseCase _setDurationPushUseCase;
  final CancelNotificationsUseCase _cancelNotificationsUseCase;
  final CheckPermissionUseCase _checkPermissionUseCase;
  final SaveDurationNotificationUseCase _saveDurationNotificationUseCase;
  final GetDurationNotificationUseCase _getDurationNotificationUseCase;
  final RemoveDurationNotificationInSharedPrefsUseCase
  _removeDurationNotificationInSharedPrefsUseCase;

  HomeState get state => _state;

  Future<void> onAction(HomeAction action) async {
    switch (action) {
      case OnChangedDuration(:final Duration duration):
        await _setDurationPush(duration);
      case CheckNotifications():
        await _findPendingNotifications();
      case CancelNotifications():
        await _cancelNotifications();
    }
  }

  Future<void> _setDurationPush(Duration duration) async {
    await _checkPermissionUseCase.execute(PermissionType.notification);

    _state = state.copyWith(duration: duration);

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

    notifyListeners();
  }

  Future<void> _findPendingNotifications() async {
    final notification = await _getDurationNotificationUseCase.execute();
    _logger.d(notification);
  }

  Future<void> _cancelNotifications() async {
    await _cancelNotificationsUseCase.execute();
    await _removeDurationNotificationInSharedPrefsUseCase.execute();
    _state = _state.copyWith(duration: Duration.zero);
    notifyListeners();
  }
}
