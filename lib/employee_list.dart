import 'package:flutter/material.dart';

class Employee {
  final String name;
  final String position;
  final IconData icon;

  Employee({required this.name, required this.position, required this.icon});
}

final List<Employee> employees = [
  Employee(name: 'Budi', position: 'Room Boy', icon: Icons.account_circle),
];
