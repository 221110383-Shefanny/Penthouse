import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting
import 'package:flutter_application_9/pages/profile_page.dart'; // Import ProfilePage
import 'package:flutter_application_9/pages/general_affair.dart';
import 'package:flutter_application_9/pages/insight.dart';
import 'package:flutter_application_9/pages/inventory.dart';
import 'package:flutter_application_9/pages/room.dart';
import 'package:flutter_application_9/pages/supervisor/employee.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final String userRole;
  final String userEmail;
  final IconData userIcon;
  final String userUid;
  final String phoneNumber;
  final String address;
  final String dateOfBirth; // Assuming this is a string date
  final String dateJoined; // Assuming this is a string date

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

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Function to format the date
  String formatDate(String date) {
    try {
      // Try parsing the date with DateTime.parse() (ISO format)
      DateTime dateTime = DateTime.parse(date);
      final DateFormat formatter = DateFormat('dd MMMM yyyy'); // Desired format
      return formatter.format(dateTime); // Returning formatted date
    } catch (e) {
      // If it's not in ISO format, handle other formats using DateFormat
      try {
        // Use custom format (change this pattern if needed)
        final DateFormat customFormat =
            DateFormat('yyyy-MM-dd'); // Example pattern
        DateTime dateTime =
            customFormat.parse(date); // Parse custom formatted date
        final DateFormat formatter =
            DateFormat('dd MMMM yyyy'); // Desired format
        return formatter.format(dateTime); // Returning formatted date
      } catch (e) {
        // Handle the error gracefully if the date format is not correct
        print("Error parsing date: $e");
        return "Invalid Date"; // Default error string
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Penthouse"),
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/penthouse.png', height: 200)),
            Text(
              "Welcome back, ${widget.userName}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "You Logged In as ${widget.userRole}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildCard(
                    icon: Icons.map,
                    title: "Room",
                    color: Colors.blue[100],
                    page: const RoomLayout(),
                  ),
                  _buildCard(
                    icon: Icons.business_center,
                    title: "General Affair",
                    color: Colors.green[100],
                    page: const GeneralAffair(),
                  ),
                  _buildCard(
                    icon: Icons.inventory,
                    title: "Inventory",
                    color: Colors.orange[100],
                    page: const Inventory(),
                  ),
                  _buildCard(
                    icon: Icons.insights,
                    title: "Insight",
                    color: Colors.purple[100],
                    page: const InsightPage(),
                  ),
                  _buildEmployeeCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
          if (index == 2) {
            // Navigate to ProfilePage when profile icon is tapped
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

  Widget _buildEmployeeCard() {
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
            const Text(
              "Employee",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
