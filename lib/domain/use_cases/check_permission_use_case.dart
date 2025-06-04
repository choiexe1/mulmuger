import 'package:mulmuger/domain/enums/permission_type.dart';
import 'package:mulmuger/domain/services/permission_service.dart';

class CheckPermissionUseCase {
  const CheckPermissionUseCase(this._permissionService);

  final PermissionService _permissionService;

  Future<void> execute(PermissionType type) async {
    return _permissionService.checkPermission(type);
  }
}
