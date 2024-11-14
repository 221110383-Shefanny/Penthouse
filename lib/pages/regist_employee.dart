import 'package:flutter/material.dart';
import 'package:flutter_application_9/employee_list.dart';

class RegistEmployee extends StatefulWidget {
  const RegistEmployee({super.key});

  @override
  State<RegistEmployee> createState() => _RegistEmployeeState();
}

class _RegistEmployeeState extends State<RegistEmployee> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  IconData selectedIcon = Icons.account_circle;

  Future<void> _addEmployee() async {
    await Future.delayed(Duration(seconds: 1));

    if (nameController.text.isNotEmpty && positionController.text.isNotEmpty) {
      final newEmployee = Employee(
        name: nameController.text,
        position: positionController.text,
        username: usernameController.text,
        password: passwordController.text,
        icon: selectedIcon,
      );

      setState(() {
        employees.add(newEmployee);
      });

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register New Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: positionController,
              decoration: InputDecoration(labelText: "Position"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addEmployee();
              },
              child: Text("Add Employee"),
            ),
          ],
        ),
      ),
    );
  }
}
