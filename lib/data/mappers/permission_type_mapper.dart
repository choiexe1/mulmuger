import 'package:mulmuger/domain/enums/permission_type.dart';
import 'package:permission_handler/permission_handler.dart';

extension PermissionTypeMapper on PermissionType {
  Permission toPermission() {
    switch (this) {
      case PermissionType.notification:
        return Permission.notification;
    }
  }
}
