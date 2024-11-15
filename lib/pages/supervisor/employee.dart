import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/regist_employee.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegistEmployee()),
              ).then((_) {
                setState(() {});
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('employees').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No employees found.'));
          }

          // Debugging: print the raw data to the console
          debugPrint('Employees Data: ${snapshot.data!.docs}');

          final employees = snapshot.data!.docs;

          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employeeData = employees[index];

              // Debugging: print individual employee data
              debugPrint('Employee $index: ${employeeData.data()}');

              return ListTile(
                leading: Icon(
                  IconData(
                    employeeData['icon'] ?? Icons.account_circle.codePoint,
                    fontFamily: 'MaterialIcons',
                  ),
                  size: 40,
                  color: Colors.blue,
                ),
                title: Text(employeeData['name'] ?? 'No Name'),
                subtitle: Text(employeeData['position'] ?? 'No Position'),
              );
            },
          );
        },
      ),
    );
  }
}
