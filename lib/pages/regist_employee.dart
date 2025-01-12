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
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        String uid = userCredential.user!.uid;

        final newEmployee = {
          'name': nameController.text,
          'position': positionController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'icon': selectedIcon.codePoint,
          'uid': uid,
        };

        await FirebaseFirestore.instance
            .collection('employees')
            .doc(uid)
            .set(newEmployee);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } catch (e) {
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
