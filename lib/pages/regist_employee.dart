import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/login.dart';

class RegistEmployee extends StatefulWidget {
  const RegistEmployee({super.key});

  @override
  State<RegistEmployee> createState() => _RegistEmployeeState();
}

class _RegistEmployeeState extends State<RegistEmployee> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  IconData selectedIcon = Icons.account_circle;

  Future<void> _addEmployee() async {
    if (nameController.text.isNotEmpty &&
        positionController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      try {
        // Daftarkan pengguna ke Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // Ambil UID pengguna yang baru terdaftar
        String uid = userCredential.user!.uid;

        // Menyimpan data ke Firestore
        final newEmployee = {
          'name': nameController.text,
          'position': positionController.text,
          'email': emailController.text,
          'password': passwordController
              .text, // Biasanya tidak disarankan untuk menyimpan password
          'icon': selectedIcon.codePoint,
          'uid': uid, // Simpan UID pengguna
        };

        await FirebaseFirestore.instance
            .collection('employees')
            .doc(uid) // Gunakan UID untuk membuat dokumen unik per pengguna
            .set(newEmployee);

        // Setelah data berhasil disimpan, pindah ke halaman login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } catch (e) {
        // Menangani error jika ada
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register New Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: positionController,
              decoration: InputDecoration(labelText: "Position"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addEmployee,
              child: Text("Add Employee"),
            ),
          ],
        ),
      ),
    );
  }
}
