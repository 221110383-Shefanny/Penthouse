import 'dart:async';

import 'package:flutter/material.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final StreamController<List<Map<String, String>>> streamController =
      StreamController<List<Map<String, String>>>();
  final List<Map<String, String>> checkinHistory = [
    {'nama': 'anto', 'checkin': '10:00', 'tanggal': '2024-09-24 '},
    {'nama': 'suria', 'checkin': '09:30', 'tanggal': '2024-03-12 '},
    {'nama': 'budi', 'checkin': '08:45', 'tanggal': '2024-01-09 '},
  ];
  DateTime? selectedDate;

  Future<void> streamData() async {
    streamController.add(checkinHistory);
  }

  @override
  void initState() {
    super.initState();
    streamData();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Check-In'),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<List<Map<String, String>>>(
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            print("Error");
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No checkout history available"));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showChoiceDialog(context);
                  },
                  child: const Text('Pilih Opsi'),
                ),
                const Text(
                  "Insight Check-In",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInsightCard(
                  title: "Total Check-Ins",
                  value: "${snapshot.data!.length}",
                  icon: Icons.check_circle,
                  color: Colors.green,
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                const Text(
                  "Riwayat Check-In",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return ListTile(
                        leading: const Icon(Icons.login, color: Colors.green),
                        title: Text(item['nama']!),
                        subtitle: Text('Check-in: ${item['checkin']}'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInsightCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          title: Text(title),
          subtitle: Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

void _showChoiceDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Pilih Opsi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Opsi 1'),
              onTap: () {
                Navigator.of(context).pop();
                print('Opsi 1 dipilih');
              },
            ),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Opsi 2'),
              onTap: () {
                Navigator.of(context).pop();
                print('Opsi 2 dipilih');
              },
            ),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Opsi 3'),
              onTap: () {
                Navigator.of(context).pop();
                print('Opsi 3 dipilih');
              },
            ),
          ],
        ),
      );
    },
  );
}
