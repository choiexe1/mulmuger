import 'package:mulmuger/domain/enums/permission_type.dart';

abstract interface class PermissionService {
  Future<void> checkPermission(PermissionType type);
}
