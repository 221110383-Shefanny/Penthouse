import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/supervisor.dart/InsightPage.dart';

class HomePage extends StatelessWidget {
  final String userName;

  const HomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Penthouse"),
      ),
      body: Container(
        color: Colors.grey[100], // Ubah warna background
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/penthouse.png', height: 200)),
            Text(
              "Welcome back, $userName",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              "You Logged In as 'role'",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildCard(Icons.map, "Room", Colors.blue[100], () {}),
                  _buildCard(Icons.business_center, "General Affair",
                      Colors.green[100], () {}),
                  _buildCard(
                      Icons.inventory, "Inventory", Colors.orange[100], () {}),
                  _buildCard(Icons.insights, "Insight", Colors.purple[100], () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InsightPage()),
                    );
                  }),
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
        onTap: (index) {},
      ),
    );
  }

  Widget _buildCard(
      IconData icon, String title, Color? color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
      onTap: () {},
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
