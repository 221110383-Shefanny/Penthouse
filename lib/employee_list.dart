import 'package:flutter/material.dart'; // Import IconData dan widget lainnya

class Employee {
  final String uid;
  final String name;
  final String position;
  final String email;
  final String password;
  final IconData icon; // Menggunakan IconData
  final String phoneNumber;
  final String address;
  final DateTime dateOfBirth;
  final DateTime dateJoined;

  // Constructor untuk Employee
  Employee({
    required this.uid,
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

  // Factory method untuk konversi data Firebase menjadi objek Employee
  factory Employee.fromFirestore(Map<String, dynamic> data, String uid) {
    // Mengonversi icon ke IconData dari data yang diterima
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
      dateOfBirth: DateTime.parse(data['dateOfBirth']),
      dateJoined: DateTime.parse(data['dateJoined']),
    );
  }
}
