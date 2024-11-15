import 'package:flutter/material.dart';

class Employee {
  final String name;
  final String position;
  final String email; // Mengganti username menjadi email
  final String password;
  final IconData icon;

  Employee({
    required this.name,
    required this.position,
    required this.email, // Menggunakan email alih-alih username
    required this.password,
    required this.icon,
  });
}

final List<Employee> employees = [
  Employee(
    name: 'Budi',
    position: 'Room Boy',
    email: 'budihartono123@example.com', // Mengganti username menjadi email
    password: 'akuganteng',
    icon: Icons.account_circle,
  ),
];
