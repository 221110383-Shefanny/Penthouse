import 'package:permission_handler/permission_handler.dart';
import 'notification_permission.dart';
import 'storage_permission.dart';

class PermissionHandler {
  static Future<void> requestAllPermissions() async {
    await NotificationPermission.requestPermission();
    await StoragePermission.requestPermission();
  }
}
