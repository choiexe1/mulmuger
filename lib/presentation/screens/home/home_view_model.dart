import 'package:flutter/material.dart';
import 'package:mulmuger/domain/use_cases/set_duration_push_use_case.dart';
import 'package:mulmuger/presentation/screens/home/home_action.dart';
import 'package:mulmuger/presentation/screens/home/home_state.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel(this._setDurationPushUseCase);

  HomeState _state = const HomeState();

  final SetDurationPushUseCase _setDurationPushUseCase;

  HomeState get state => _state;

  Future<void> onAction(HomeAction action) async {
    switch (action) {
      case OnChangedDuration(:final Duration duration):
        await _setDurationPush(duration);
      case CheckNotifications():
      case DeleteNotifications():
    }
  }

  Future<void> _setDurationPush(Duration duration) async {
    _state = state.copyWith(duration: duration);
    await _setDurationPushUseCase.execute(
      duration: duration,
      body: '물 먹을 시간이에요',
    );
  }
}
