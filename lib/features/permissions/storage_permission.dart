import 'package:permission_handler/permission_handler.dart';

class StoragePermission {
  static Future<void> requestPermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      print("Storage permission granted.");
    } else {
      print("Storage permission denied.");
    }
  }
}
