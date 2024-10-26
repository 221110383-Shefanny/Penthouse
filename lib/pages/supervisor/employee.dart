import 'package:flutter/material.dart';
import 'package:flutter_application_9/employee_list.dart';
import 'package:flutter_application_9/pages/regist_employee.dart';

class Employee extends StatelessWidget {
  const Employee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegistEmployee()));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return ListTile(
            leading: Icon(
              employee.icon,
              size: 40,
              color: Colors.blue,
            ),
            title: Text(employee.name),
            subtitle: Text(employee.position),
          );
        },
      ),
    );
  }
}
