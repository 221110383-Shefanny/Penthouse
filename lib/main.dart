import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/firebase_options.dart';
import 'package:flutter_application_9/pages/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Panggil fungsi untuk meminta izin
  await requestPermissions();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
        supportedLocales: [
          Locale('en'), // English
          Locale('es'), // Spanish
  ],
        locale: Locale('en'),
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

// Fungsi untuk meminta izin
Future<void> requestPermissions() async {
  // Minta izin notifikasi
  PermissionStatus notificationStatus = await Permission.notification.request();
  if (notificationStatus.isGranted) {
    debugPrint("Notification permission granted.");
  } else {
    debugPrint("Notification permission denied.");
  }

  // Minta izin penyimpanan
  PermissionStatus storageStatus = await Permission.storage.request();
  if (storageStatus.isGranted) {
    debugPrint("Storage permission granted.");
  } else {
    debugPrint("Storage permission denied.");
  }
}
