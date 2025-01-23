import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi login
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error during login: $e");
      return null;
    }
  }

  String? getLoggedInUserEmail() {
    final User? user = _auth.currentUser;
    return user?.email;
  }

  // Logout pengguna
  Future<void> logout() async {
    await _auth.signOut();
  }
}
