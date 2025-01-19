import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final String position;
  final String icon;
  final String uid;

  // Konstruktor untuk menerima parameter
  const ProfilePage({
    Key? key,
    required this.name,
    required this.email,
    required this.position,
    required this.icon,
    required this.uid,
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
            // Bagian Foto Profil
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage(icon), // Menggunakan URL dari 'icon'
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name, // Nama dari parameter
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email, // Email dari parameter
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Bagian Informasi Tambahan
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blue),
              title: const Text("Phone"),
              subtitle: Text("12345678"), // Ganti dengan nomor telepon user
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.red),
              title: const Text("Address"),
              subtitle: Text("lalalala"), // Ganti dengan alamat
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.green),
              title: const Text("Date of Birth"),
              subtitle: const Text("lalalala"), // Ganti dengan tanggal lahir
            ),
            const Divider(),
            // Tombol Edit Profile
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Tambahkan fungsi edit profile
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
