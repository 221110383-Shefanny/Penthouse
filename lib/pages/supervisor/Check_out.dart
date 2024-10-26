import 'package:flutter/material.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  // Data dummy untuk check-out
  final List<Map<String, String>> checkoutHistory = [
    {'nama': 'John Doe', 'checkout': '12:00'},
    {'nama': 'Jane Smith', 'checkout': '11:15'},
    {'nama': 'Michael Johnson', 'checkout': '11:50'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat Check-Out'),
          backgroundColor: Colors.redAccent,
        ),
        body: Padding(
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
                value: "${checkoutHistory.length}",
                icon: Icons.check_circle,
                color: Colors.green,
                onPressed: () {
                  // Aksi saat kartu ditekan, bisa ditambahkan jika perlu
                },
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
                  itemCount: checkoutHistory.length,
                  itemBuilder: (context, index) {
                    final item = checkoutHistory[index];
                    return ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: Text(item['nama']!),
                      subtitle: Text('Check-out: ${item['checkout']}'),
                    );
                  },
                ),
              )
            ],
          ),
        ));
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
    onTap: onPressed, // Aksi saat kartu ditekan
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
