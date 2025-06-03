import 'package:mulmuger/domain/services/local_push_service.dart';

class SetDurationPushUseCase {
  const SetDurationPushUseCase(this._notificationService);

  final LocalPushService _notificationService;

  Future<void> execute({
    required Duration duration,
    required String body,
  }) async {
    await _notificationService.durationPush(body: body, duration: duration);
  }
}
