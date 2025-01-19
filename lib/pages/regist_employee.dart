import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/login.dart';
import 'package:intl/intl.dart'; // Import intl untuk format tanggal

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
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  DateTime? selectedDateOfBirth;
  DateTime? selectedDateJoined;

  IconData selectedIcon = Icons.account_circle;

  // Fungsi untuk format tanggal
  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  Future<void> _addEmployee() async {
    if (nameController.text.isNotEmpty &&
        positionController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        selectedDateOfBirth != null &&
        selectedDateJoined != null) {
      try {
        // Create user with email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        String uid = userCredential.user!.uid;

        // Prepare employee data
        final newEmployee = {
          'name': nameController.text,
          'position': positionController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'phoneNumber': phoneNumberController.text,
          'address': addressController.text,
          'dateOfBirth': selectedDateOfBirth!.toIso8601String(),
          'dateJoined': selectedDateJoined!.toIso8601String(),
          'icon': selectedIcon.codePoint,
          'uid': uid,
        };

        // Save to Firestore
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all fields")));
    }
  }

  Future<void> _selectDate(BuildContext context, bool isDateOfBirth) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        if (isDateOfBirth) {
          selectedDateOfBirth = pickedDate;
        } else {
          selectedDateJoined = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register New Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: positionController,
                decoration: const InputDecoration(labelText: "Position"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: "Address"),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      selectedDateOfBirth == null
                          ? "Date of Birth: Not Selected"
                          : "Date of Birth: ${_formatDate(selectedDateOfBirth!)}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context, true),
                    child: const Text("Select"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      selectedDateJoined == null
                          ? "Date Joined: Not Selected"
                          : "Date Joined: ${_formatDate(selectedDateJoined!)}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context, false),
                    child: const Text("Select"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addEmployee,
                child: const Text("Add Employee"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
