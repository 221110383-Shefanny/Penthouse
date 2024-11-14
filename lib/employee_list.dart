import 'package:flutter/material.dart';

class Employee {
  final String name;
  final String position;
  final String username;
  final String password;
  final IconData icon;

  Employee(
      {required this.name,
      required this.position,
      required this.username,
      required this.password,
      required this.icon});
}

final List<Employee> employees = [
  Employee(
      name: 'Budi',
      position: 'Room Boy',
      username: 'budihartono123',
      password: 'akuganteng',
      icon: Icons.account_circle),
];
