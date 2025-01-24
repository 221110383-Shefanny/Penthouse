import 'package:flutter/material.dart';
import 'package:flutter_application_9/main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_9/pages/profile_page.dart';
import 'package:flutter_application_9/pages/general_affair.dart';
import 'package:flutter_application_9/pages/insight.dart';
import 'package:flutter_application_9/pages/inventory.dart';
import 'package:flutter_application_9/pages/room.dart';
import 'package:flutter_application_9/pages/supervisor/employee.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final String userRole;
  final String userEmail;
  final IconData userIcon;
  final String userUid;
  final String phoneNumber;
  final String address;
  final String dateOfBirth;
  final String dateJoined;

  const HomePage({
    Key? key,
    required this.userName,
    required this.userRole,
    required this.userEmail,
    required this.userIcon,
    required this.userUid,
    required this.phoneNumber,
    required this.address,
    required this.dateOfBirth,
    required this.dateJoined,
  }) : super(key: key);

  String formatDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      final DateFormat formatter = DateFormat('dd MMMM yyyy');
      return formatter.format(dateTime);
    } catch (e) {
      try {
        final DateFormat customFormat = DateFormat('yyyy-MM-dd');
        DateTime dateTime = customFormat.parse(date);
        final DateFormat formatter = DateFormat('dd MMMM yyyy');
        return formatter.format(dateTime);
      } catch (e) {
        print("Error parsing date: $e");
        return "Invalid Date";
      }
    }
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BannerAd _bannerAd;

  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-3940256099942544/9214589741',
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          _isBannerAdReady = false;
          ad.dispose();
          print('BannerAd failed to load: $error');
        },
      ),
      request: AdRequest(),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        actions: [
          DropdownButton<Locale>(
            value: Localizations.localeOf(context),
            icon: const Icon(Icons.language, color: Colors.black),
            dropdownColor: Colors.blue,
            underline: Container(),
            items: [
              DropdownMenuItem(
                value: const Locale('en'),
                child: Text('English',
                    style: const TextStyle(color: Colors.black)),
              ),
              DropdownMenuItem(
                value: const Locale('id'),
                child: Text('Bahasa Indonesia',
                    style: const TextStyle(color: Colors.black)),
              ),
            ],
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                Provider.of<LanguageProvider>(context, listen: false)
                    .setLocale(newLocale);
              }
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/penthouse.png', height: 200)),
            Text(
              localizations.welcomeMessage(widget.userName),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              localizations.userRoleMessage(widget.userRole),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),
            const SizedBox(height: 25),

            // Wrap GridView in a SingleChildScrollView to avoid overflow
            Expanded(
              child: SingleChildScrollView(
                child: GridView.count(
                  physics:
                      NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                  shrinkWrap:
                      true, // Allow the GridView to take up only as much space as needed
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildCard(
                      icon: Icons.map,
                      title: localizations.room,
                      color: Colors.blue[100],
                      page: const RoomLayout(),
                    ),
                    _buildCard(
                      icon: Icons.business_center,
                      title: localizations.generalAffair,
                      color: Colors.green[100],
                      page: const GeneralAffair(),
                    ),
                    _buildCard(
                      icon: Icons.inventory,
                      title: localizations.inventory,
                      color: Colors.orange[100],
                      page: const Inventory(),
                    ),
                    _buildCard(
                      icon: Icons.insights,
                      title: localizations.insight,
                      color: Colors.purple[100],
                      page: const InsightPage(),
                    ),
                    _buildEmployeeCard(localizations),
                  ],
                ),
              ),
            ),

            // Ad widget
            if (_isBannerAdReady)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: localizations.appTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.message),
            label: localizations.message,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: localizations.profile,
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  name: widget.userName,
                  email: widget.userEmail,
                  position: widget.userRole,
                  icon: widget.userIcon,
                  phoneNumber: widget.phoneNumber,
                  address: widget.address,
                  dateOfBirth: widget.dateOfBirth,
                  dateJoined: widget.dateJoined,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required Color? color,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeCard(AppLocalizations localizations) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Employee(),
          ),
        );
      },
      child: Card(
        color: Colors.lightBlue[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people, size: 50),
            const SizedBox(height: 10),
            Text(
              localizations.employee, // Localized title
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
