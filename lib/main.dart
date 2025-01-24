import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/firebase_options.dart';
import 'package:flutter_application_9/pages/login.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure that Flutter bindings are initialized before any platform-specific work
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize MobileAds and Firebase only after Flutter bindings are ready
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Request permissions
  await requestPermissions();

  // Run the app with LanguageProvider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('id'), // Indonesian
      ],
      locale: Provider.of<LanguageProvider>(context)
          .locale, // Set locale dynamically
      home: const Login(),
    );
  }
}

Future<void> requestPermissions() async {
  PermissionStatus notificationStatus = await Permission.notification.request();
  if (notificationStatus.isGranted) {
    debugPrint("Notification permission granted.");
  } else {
    debugPrint("Notification permission denied.");
  }

  // Request storage permission
  PermissionStatus storageStatus = await Permission.storage.request();
  if (storageStatus.isGranted) {
    debugPrint("Storage permission granted.");
  } else {
    debugPrint("Storage permission denied.");
  }
}

/// Language Provider for managing app language
class LanguageProvider with ChangeNotifier {
  // Default language set to Indonesian
  Locale _locale = const Locale('id');

  Locale get locale => _locale;
  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners(); // Notify widgets to rebuild with new locale
    }
  }
}
