import 'package:mulmuger/domain/services/local_push_service.dart';

class SetDurationPushUseCase {
  const SetDurationPushUseCase(this._notificationService);

  final LocalPushService _notificationService;

  Future<void> execute({
    required int id,
    required Duration duration,
    required String title,
    required String body,
  }) async {
    await _notificationService.durationPush(
      id: id,
      title: title,
      body: body,
      duration: duration,
    );
  }
}
