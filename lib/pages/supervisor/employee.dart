import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/regist_employee.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import localization package

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.employeeList), // Localized title
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
            return Center(child: Text(localizations.noEmployees)); // Localized text
          }

          final employees = snapshot.data!.docs;

          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employeeData = employees[index];
              final docId = employeeData.id;

              return ListTile(
                leading: const Icon(
                  Icons.account_circle,
                  size: 40,
                  color: Colors.blue,
                ),
                title: Text(employeeData['name'] ?? localizations.noName), // Localized text
                subtitle: Text(employeeData['position'] ?? localizations.noPosition), // Localized text
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditEmployee(
                              employeeId: docId,
                              initialData: employeeData.data() as Map<String, dynamic>,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(localizations.deleteEmployee), // Localized title
                            content: Text(localizations.confirmDelete), // Localized text
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(localizations.cancel), // Localized text
                              ),
                              TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('employees')
                                      .doc(docId)
                                      .delete()
                                      .then((_) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(localizations.employeeDeleted)), // Localized text
                                    );
                                  });
                                },
                                child: Text(localizations.delete), // Localized text
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EditEmployee extends StatelessWidget {
  final String employeeId;
  final Map<String, dynamic> initialData;

  const EditEmployee({
    super.key,
    required this.employeeId,
    required this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    final nameController = TextEditingController(text: initialData['name']);
    final addressController = TextEditingController(text: initialData['address']);
    final emailController = TextEditingController(text: initialData['email']);
    final phoneNumberController = TextEditingController(text: initialData['phoneNumber']);
    final positionController = TextEditingController(text: initialData['position']);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.editEmployee), // Localized title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: localizations.name), 
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: localizations.address), 
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: localizations.email), 
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: localizations.phoneNumber), 
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: positionController,
                decoration: InputDecoration(labelText: localizations.position), 
              ),
              const SizedBox(height: 16),
              Text(
                '${localizations.dateOfBirth}: ${initialData['dateOfBirth'] != null ? initialData['dateOfBirth'].substring(0, 10) : localizations.notAvailable}', // Localized text
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '${localizations.dateJoined}: ${initialData['dateJoined'] != null ? initialData['dateJoined'].substring(0, 10) : localizations.notAvailable}', // Localized text
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('employees')
                      .doc(employeeId)
                      .update({
                    'name': nameController.text,
                    'address': addressController.text,
                    'email': emailController.text,
                    'phoneNumber': phoneNumberController.text,
                    'position': positionController.text,
                  }).then((_) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(localizations.employeeUpdated)), // Localized text
                    );
                  });
                },
                child: Text(localizations.saveChanges), // Localized text
              ),
            ],
          ),
        ),
      ),
    );
  }
}
