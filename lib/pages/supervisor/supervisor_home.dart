import 'package:flutter/material.dart';
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
  final String userIcon;
  final String userUid;

  const HomePage({
    Key? key,
    required this.userName,
    required this.userRole,
    required this.userEmail,
    required this.userIcon,
    required this.userUid,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  _buildProfileCard(), // Menambahkan tombol untuk membuka ProfilePage
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
            // Navigasi ke ProfilePage saat menekan ikon profile
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  name: widget.userName,
                  email: widget.userEmail,
                  position: widget.userRole,
                  icon: widget.userIcon,
                  uid: widget.userUid,
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

  Widget _buildProfileCard() {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman ProfilePage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              name: widget.userName,
              email: widget.userEmail,
              position: widget.userRole,
              icon: widget.userIcon,
              uid: widget.userUid,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.lightGreen[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.person, size: 50),
            SizedBox(height: 10),
            Text(
              "Profile",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
