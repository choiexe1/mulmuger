import 'package:mulmuger/domain/repositories/local_push_repository.dart';

class SetDurationPushUseCase {
  const SetDurationPushUseCase(this._localPushRepository);

  final LocalPushRepository _localPushRepository;

  Future<void> execute({
    required int id,
    required Duration duration,
    required String title,
    required String body,
  }) async {
    await _localPushRepository.durationPush(
      id: id,
      title: title,
      body: body,
      duration: duration,
    );
  }
}
