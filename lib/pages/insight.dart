import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/Check_in.dart';
import 'package:flutter_application_9/pages/Check_out.dart';
import 'package:flutter_application_9/pages/general_affairhistory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import the localization package

class InsightPage extends StatelessWidget {
  const InsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle), // Localized app title
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildInsightCard(
              title: localizations.checkIn, // Localized title
              value: localizations.checkInValue, // Localized value
              icon: Icons.login,
              color: Colors.green,
              onPressed: () {
                _navigateToPage(context, const CheckInPage());
              },
            ),
            const SizedBox(height: 20),
            _buildInsightCard(
              title: localizations.checkOut, // Localized title
              value: localizations.checkOutValue, // Localized value
              icon: Icons.logout,
              color: Colors.redAccent,
              onPressed: () {
                _navigateToPage(context, const CheckOutPage());
              },
            ),
            const SizedBox(height: 20),
            _buildInsightCard(
              title: localizations.generalAffair, // Localized title
              value: localizations.generalAffairValue, // Localized value
              icon: Icons.cleaning_services,
              color: Colors.blueAccent,
              onPressed: () {
                _navigateToPage(context, const GeneralAffairhistory());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          title: Text(title),
          subtitle: Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, -1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
