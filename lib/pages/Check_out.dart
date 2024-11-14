import 'dart:async';
import 'package:flutter/material.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final StreamController<List<Map<String, String>>> streamController =
      StreamController<List<Map<String, String>>>();

  List<Map<String, String>> checkoutHistory = [
    {'nama': 'anto', 'checkout': '12:00'},
    {'nama': 'suria', 'checkout': '11:15'},
    {'nama': 'budi', 'checkout': '11:50'},
  ];

  Future<void> streamData() async {
    streamController.add(checkoutHistory);
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
        title: const Text('Riwayat Check-Out'),
        backgroundColor: Colors.redAccent,
      ),
      body: StreamBuilder<List<Map<String, String>>>(
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No checkout history available"));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Insight Check-Out",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInsightCard(
                  title: "Total Check-Outs",
                  value: "${snapshot.data!.length}",
                  icon: Icons.check_circle,
                  color: Colors.green,
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                const Text(
                  "Riwayat Check-Out",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: Text(item['nama']!),
                        subtitle: Text('Check-out: ${item['checkout']}'),
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
