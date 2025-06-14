import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_action.freezed.dart';

@freezed
sealed class HomeAction with _$HomeAction {
  const factory HomeAction.onChangedDuration(Duration duration) =
      OnChangedDuration;
  const factory HomeAction.checkNotifications() = CheckNotifications;
  const factory HomeAction.deleteNotifications() = CancelNotifications;
  const factory HomeAction.clearWater() = ClearWater;
}
