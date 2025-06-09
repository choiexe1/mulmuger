import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default(Duration.zero) Duration duration,
    @Default(0) double water,
    @Default('현재 설정된 알람이 없어요!') String message,
  }) = _HomeState;
}
