import 'package:mulmuger/domain/notification/notification_action.dart';
import 'package:mulmuger/domain/repositories/local_push_repository.dart';

class ListenNotificationActionStreamUseCase {
  const ListenNotificationActionStreamUseCase(this._repository);

  final LocalPushRepository _repository;

  Stream<NotificationAction> execute() {
    return _repository.notificationActionStream;
  }
}
