import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/supervisor/supervisor_home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible = false;
  bool isLoading = false; // Variabel untuk indikator loading
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
      isLoading = true; // Tampilkan loading saat proses login dimulai
    });

    try {
      // Pastikan menggunakan email dan password untuk login
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Jika login berhasil, arahkan pengguna ke halaman Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userName: "Supervisor"),
        ),
      );
    } catch (e) {
      setState(() {
        isLoading =
            false; // Menyembunyikan indikator loading setelah gagal login
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
                  onPressed: isLoading
                      ? null
                      : _signIn, // Disable button while loading
                  child: isLoading
                      ? const CircularProgressIndicator() // Tampilkan loading saat proses login
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
