import 'dart:convert';

import 'package:mulmuger/domain/entities/notification_entity.dart';
import 'package:mulmuger/domain/enums/notification_type.dart';
import 'package:mulmuger/domain/repositories/shared_prefs_local_repository.dart';

class GetDurationNotificationUseCase {
  const GetDurationNotificationUseCase(this._repository);

  final SharedPrefsLocalRepository _repository;

  Future<NotificationEntity?> execute() async {
    final json = _repository.get<String>(
      NotificationType.duration.id.toString(),
    );

    if (json != null) {
      final map = jsonDecode(json) as Map<String, dynamic>;
      return NotificationEntity.fromJson(map);
    }

    return null;
  }
}
