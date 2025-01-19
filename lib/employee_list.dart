import 'package:flutter/material.dart';

class Employee {
  final String name;
  final String position;
  final String email; // Mengganti username menjadi email
  final String password;
  final IconData icon;
  final String phoneNumber; // Tambahkan nomor HP
  final String address; // Tambahkan alamat
  final DateTime dateOfBirth; // Tambahkan tanggal lahir
  final DateTime dateJoined; // Tambahkan tanggal bergabung

  Employee({
    required this.name,
    required this.position,
    required this.email, // Menggunakan email alih-alih username
    required this.password,
    required this.icon,
    required this.phoneNumber,
    required this.address,
    required this.dateOfBirth,
    required this.dateJoined,
  });
}

final List<Employee> employees = [
  Employee(
    name: 'Budi',
    position: 'Room Boy',
    email: 'budihartono123@example.com',
    password: 'akuganteng',
    phoneNumber: '081234567890', // Input manual
    address: 'Jalan Mawar No. 123, Jakarta', // Input manual
    dateOfBirth: DateTime(1995, 5, 20), // Input manual
    dateJoined: DateTime(2020, 1, 15), // Input manual
    icon: Icons.account_circle,
  ),
];
