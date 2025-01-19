import 'package:flutter/material.dart'; // Ini untuk mengimpor IconData

class Employee {
  final String uid; // Tambahkan UID
  final String name;
  final String position;
  final String email;
  final String password;
  final IconData icon;
  final String phoneNumber;
  final String address;
  final DateTime dateOfBirth;
  final DateTime dateJoined;

  Employee({
    required this.uid, // UID wajib
    required this.name,
    required this.position,
    required this.email,
    required this.password,
    required this.icon,
    required this.phoneNumber,
    required this.address,
    required this.dateOfBirth,
    required this.dateJoined,
  });

  // Factory method untuk konversi dari Firebase DocumentSnapshot
  factory Employee.fromFirestore(Map<String, dynamic> data, String uid) {
    return Employee(
      uid: uid,
      name: data['name'],
      position: data['position'],
      email: data['email'],
      password: data['password'],
      icon:
          IconData(data['icon'], fontFamily: 'MaterialIcons'), // Konversi icon
      phoneNumber: data['phoneNumber'],
      address: data['address'],
      dateOfBirth: DateTime.parse(data['dateOfBirth']), // Konversi dari string
      dateJoined: DateTime.parse(data['dateJoined']), // Konversi dari string
    );
  }
}
