import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/supervisor/supervisor_home.dart';

//TIDAK ADA TOMBOL SIGN UP KARENA HANYA AKUN SUPERVISOR YANG DAPAT MENDAFTARKAN AKUN BARU
//AKUN SUPERVISOR HANYA UNTUK MANAGER
//FITUR SIGN UP AKAN DITAMPILKAN SETELAH LOGIN AKUN SUPERVISOR

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  Future<void> _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(userName: "Supervisor")));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Login Gagal"),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"))
                ],
              ));
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
                // const Text(
                //   "Penthouse",
                //   style: TextStyle(
                //     fontSize: 40,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),

                // ini test

                Image.asset('assets/penthouse.png'),

                const SizedBox(
                  height: 50,
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 235, 199, 128),
                    prefixIcon: Icon(Icons.person),
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
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
                    alignLabelWithHint: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 70,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 235, 199, 128),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 10)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(userName: "Michael"),
                      ),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Color.fromARGB(255, 77, 77, 77),
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
