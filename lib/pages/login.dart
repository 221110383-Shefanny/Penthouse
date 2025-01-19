import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_application_9/employee_list.dart';
import 'package:flutter_application_9/pages/supervisor/supervisor_home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  bool passwordVisible = false;
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  // Fungsi untuk mengambil data karyawan dari Firestore
  Future<Employee?> fetchEmployeeData(String email) async {
    var userSnapshot = await FirebaseFirestore.instance
        .collection('employees')
        .where('email', isEqualTo: email)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      var doc = userSnapshot.docs.first;
      return Employee.fromFirestore(doc.data(), doc.id); // Pass UID (doc.id)
    }
    return null;
  }

  Future<void> _signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      var employee = await fetchEmployeeData(_emailController.text.trim());
      if (employee == null) {
        throw Exception('Akun tidak ditemukan');
      }

      if (_passwordController.text.trim() != employee.password) {
        throw Exception('Password salah');
      }

      await _auth.signInWithEmailAndPassword(
        email: employee.email,
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              userName: employee.name,
              userRole: employee.position,
              userEmail: employee.email,
              userIcon: employee.icon,
              userUid: employee.uid,
              phoneNumber: employee.phoneNumber,
              address: employee.address,
              dateOfBirth: employee.dateOfBirth.toIso8601String(),
              dateJoined: employee.dateJoined.toIso8601String(),
            ),
          ),
        );
      }

      await FirebaseFirestore.instance.collection('logs').add({
        'email': _emailController.text.trim(),
        'status': 'login',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Gagal"),
          content: Text("Akun tidak ditemukan atau password salah.\n$e"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/penthouse.png'),
                const SizedBox(height: 50),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 235, 199, 128),
                    prefixIcon: Icon(Icons.email),
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 235, 199, 128),
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 235, 199, 128),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () => _signIn(),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Login",
                          style: TextStyle(
                            color: Color.fromARGB(255, 77, 77, 77),
                            fontSize: 18,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
