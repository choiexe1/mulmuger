import 'dart:convert';

import 'package:mulmuger/domain/entities/notification_entity.dart';
import 'package:mulmuger/domain/enums/notification_type.dart';
import 'package:mulmuger/domain/repositories/shared_prefs_local_repository.dart';

class SaveDurationNotificationUseCase {
  const SaveDurationNotificationUseCase(this._repository);

  final SharedPrefsLocalRepository _repository;

  Future<void> execute(NotificationEntity entity) async {
    final json = jsonEncode(entity.toJson());

    await _repository.save<String>(
      NotificationType.duration.id.toString(),
      json,
    );
  }
}
