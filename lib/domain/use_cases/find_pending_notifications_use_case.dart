import 'package:mulmuger/domain/entities/notification_entity.dart';
import 'package:mulmuger/domain/repositories/local_push_repository.dart';

class FindPendingNotificationsUseCase {
  const FindPendingNotificationsUseCase(this._localPushRepository);

  final LocalPushRepository _localPushRepository;

  Future<List<NotificationEntity>> execute() async {
    return _localPushRepository.findPendingNotifications();
  }
}
