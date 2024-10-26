import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/general_affair.dart';
<<<<<<< HEAD:lib/pages/supervisor.dart/supervisor_home.dart
=======
import 'package:flutter_application_9/pages/insight.dart';
import 'package:flutter_application_9/pages/inventory.dart';
import 'package:flutter_application_9/pages/room.dart';
import 'package:flutter_application_9/pages/supervisor/employee.dart';
>>>>>>> e047d0b0c55f08a7052a26eaee179bd2fe0735d2:lib/pages/supervisor/supervisor_home.dart

class HomePage extends StatefulWidget {
  final String userName;

  const HomePage({super.key, required this.userName});

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
        color: Colors.grey[100], // Ubah warna background
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
<<<<<<< HEAD:lib/pages/supervisor.dart/supervisor_home.dart
                  _buildCard(context,Icons.map, "Room", Colors.blue[100],),
                  _buildCard(context,Icons.business_center, "General Affair",
                      Colors.green[100]),
                  _buildCard(context,Icons.inventory, "Inventory", Colors.orange[100]),
                  _buildCard(context,Icons.insights, "Insight", Colors.purple[100]),
=======
                  _buildCard(
                    icon: Icons.map,
                    title: "Room",
                    color: Colors.blue[100],
                    page: const Room(),
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
                    page: const Insight(),
                  ),
>>>>>>> e047d0b0c55f08a7052a26eaee179bd2fe0735d2:lib/pages/supervisor/supervisor_home.dart
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

<<<<<<< HEAD:lib/pages/supervisor.dart/supervisor_home.dart
  Widget _buildCard(BuildContext context, IconData icon, String title, Color? color, ) {
    return GestureDetector(
      onTap: () {
        if (title == "General Affair") {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> GeneralAffair()));
        }
=======
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
>>>>>>> e047d0b0c55f08a7052a26eaee179bd2fe0735d2:lib/pages/supervisor/supervisor_home.dart
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
