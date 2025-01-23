import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }
}
