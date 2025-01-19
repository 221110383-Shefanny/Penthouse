import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final String position;
  final IconData icon; // Change from String to IconData
  final String phoneNumber;
  final String address;
  final String dateOfBirth;
  final String dateJoined;

  // Constructor now takes IconData for icon
  const ProfilePage({
    Key? key,
    required this.name,
    required this.email,
    required this.position,
    required this.icon,
    required this.phoneNumber,
    required this.address,
    required this.dateOfBirth,
    required this.dateJoined,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Picture Section
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Icon(icon), // Using IconData directly
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Additional Information Section
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blue),
              title: const Text("Phone"),
              subtitle: Text(phoneNumber),
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.red),
              title: const Text("Address"),
              subtitle: Text(address),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.green),
              title: const Text("Date of Birth"),
              subtitle: Text(dateOfBirth),
            ),
            ListTile(
              leading: const Icon(Icons.date_range, color: Colors.orange),
              title: const Text("Date Joined"),
              subtitle: Text(dateJoined),
            ),
            ListTile(
              leading: const Icon(Icons.work, color: Colors.purple),
              title: const Text("Position"),
              subtitle: Text(position),
            ),
            const Divider(),
            // Edit Profile Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add edit profile functionality here
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
