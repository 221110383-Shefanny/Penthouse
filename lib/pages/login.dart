import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

  Future<void> _signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Cek apakah email dan password cocok dengan data di Firestore
      var userSnapshot = await FirebaseFirestore.instance
          .collection('employees')
          .where('email', isEqualTo: _emailController.text.trim())
          .get();

      if (userSnapshot.docs.isEmpty) {
        throw Exception('Akun tidak ditemukan');
      }

      // Verifikasi password
      String storedPassword = userSnapshot
          .docs.first['password']; // Asumsi password disimpan di Firestore
      if (_passwordController.text.trim() != storedPassword) {
        throw Exception('Password salah');
      }

      // Ambil nama dan posisi pengguna dari Firestore
      String userName = userSnapshot.docs.first['name'];
      String userRole = userSnapshot.docs.first['position'];

      // Proses login dengan Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigasi ke halaman home dengan data pengguna
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              userName: userName, // Mengirim nama pengguna
              userRole: userRole, // Mengirim posisi pengguna
            ),
          ),
        );
      }

      // Log aktivitas login ke Firebase Analytics
      await _analytics.logEvent(
        name: 'login_event',
        parameters: {
          'email': _emailController.text.trim(),
        },
      );

      // Simpan aktivitas login ke Firestore
      await FirebaseFirestore.instance.collection('logs').add({
        'email': _emailController.text.trim(),
        'status': 'login',
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Simpan aktivitas login ke Firebase Realtime Database
      DatabaseReference ref = FirebaseDatabase.instance.ref("logs");
      await ref.push().set({
        'email': _emailController.text.trim(),
        'status': 'login',
        'timestamp': ServerValue.timestamp,
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      // Menampilkan error jika login gagal
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
