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

          final employees = snapshot.data!.docs;

          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employeeData = employees[index];
              final docId =
                  employeeData.id; // ID dokumen untuk operasi Edit/Remove

              return ListTile(
                leading: const Icon(
                  Icons.account_circle,
                  size: 40,
                  color: Colors.blue,
                ),
                title: Text(employeeData['name'] ?? 'No Name'),
                subtitle: Text(employeeData['position'] ?? 'No Position'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Navigasi ke halaman edit (buat halaman edit)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditEmployee(
                              employeeId: docId,
                              initialData:
                                  employeeData.data() as Map<String, dynamic>,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Konfirmasi penghapusan
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Employee'),
                            content: const Text(
                                'Are you sure you want to delete this employee?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
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
                                      const SnackBar(
                                          content: Text(
                                              'Employee deleted successfully')),
                                    );
                                  });
                                },
                                child: const Text('Delete'),
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
    final nameController = TextEditingController(text: initialData['name']);
    final addressController =
        TextEditingController(text: initialData['address']);
    final emailController = TextEditingController(text: initialData['email']);
    final phoneNumberController =
        TextEditingController(text: initialData['phoneNumber']);
    final positionController =
        TextEditingController(text: initialData['position']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),

              TextField(
                controller: positionController,
                decoration: const InputDecoration(labelText: 'Position'),
              ),

              const SizedBox(height: 16),
              // Tampilkan data statis untuk parameter lainnya
              // Text(
              //   'Position: ${initialData['position'] ?? 'Not Available'}',
              //   style: const TextStyle(fontSize: 16),
              // ),
              const SizedBox(height: 8),
              Text(
                'Date of Birth: ${initialData['dateOfBirth'] != null ? initialData['dateOfBirth'].substring(0, 10) : 'Not Available'}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Date Joined: ${initialData['dateJoined'] != null ? initialData['dateJoined'].substring(0, 10) : 'Not Available'}',
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
                      const SnackBar(
                          content: Text('Employee updated successfully')),
                    );
                  });
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
