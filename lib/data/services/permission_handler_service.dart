import 'package:mulmuger/data/mappers/permission_type_mapper.dart';
import 'package:mulmuger/domain/enums/permission_type.dart';
import 'package:mulmuger/domain/services/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService implements PermissionService {
  @override
  Future<void> checkPermission(PermissionType type) async {
    final permission = type.toPermission();

    switch (await permission.status) {
      case PermissionStatus.denied:
        await permission.request();
      case PermissionStatus.permanentlyDenied:
        await openAppSettings();
      case PermissionStatus.granted:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.provisional:
        break;
    }
  }
}
