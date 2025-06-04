import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mulmuger/config/notification_config.dart';
import 'package:mulmuger/domain/enums/permission_type.dart';
import 'package:mulmuger/domain/use_cases/cancel_notifications_use_case.dart';
import 'package:mulmuger/domain/use_cases/check_permission_use_case.dart';
import 'package:mulmuger/domain/use_cases/find_pending_notifications_use_case.dart';
import 'package:mulmuger/domain/use_cases/set_duration_push_use_case.dart';
import 'package:mulmuger/presentation/screens/home/home_action.dart';
import 'package:mulmuger/presentation/screens/home/home_state.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel(
    this._logger,
    this._setDurationPushUseCase,
    this._cancelNotificationsUseCase,
    this._findPendingNotificationsUseCase,
    this._checkPermissionUseCase,
  );

  HomeState _state = const HomeState();

  final Logger _logger;
  final SetDurationPushUseCase _setDurationPushUseCase;
  final CancelNotificationsUseCase _cancelNotificationsUseCase;
  final FindPendingNotificationsUseCase _findPendingNotificationsUseCase;
  final CheckPermissionUseCase _checkPermissionUseCase;

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
      title: NotificationConfig.title,
      body: NotificationConfig.defaultMessage,
      duration: duration,
    );

    notifyListeners();
  }

  Future<void> _findPendingNotifications() async {
    final notifications = await _findPendingNotificationsUseCase.execute();
    notifications.forEach(_logger.d);
  }

  Future<void> _cancelNotifications() async {
    await _cancelNotificationsUseCase.execute();
    _logger.d('모든 알람 제거');
  }
}
