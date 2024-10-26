import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/supervisor.dart/supervisor_home.dart';

//TIDAK ADA TOMBOL SIGN UP KARENA HANYA AKUN SUPERVISOR YANG DAPAT MENDAFTARKAN AKUN BARU
//AKUN SUPERVISOR HANYA UNTUK MANAGER
//FITUR SIGN UP AKAN DITAMPILKAN SETELAH LOGIN AKUN SUPERVISOR

class Login extends StatelessWidget {
  const Login({super.key});

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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 235, 199, 128),
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
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
