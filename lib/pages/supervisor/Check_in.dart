import 'package:flutter/material.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  // Data dummy untuk check-in
  final List<Map<String, String>> checkinHistory = [
    {'nama': 'John Doe', 'checkin': '10:00','tanggal':'2024-09-24 '},
    {'nama': 'Jane Smith', 'checkin': '09:30', 'tanggal': '2024-03-12 '},
    {'nama': 'Michael Johnson', 'checkin': '08:45', 'tanggal': '2024-01-09 '},
  ];
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Check-In'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
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
              value: "${checkinHistory.length}",
              icon: Icons.check_circle,
              color: Colors.green,
              onPressed: () {
                // Aksi saat kartu ditekan, bisa ditambahkan jika perlu
              },
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
                itemCount: checkinHistory.length,
                itemBuilder: (context, index) {
                  final item = checkinHistory[index];
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
      ),
    );
  }

  // Fungsi untuk membangun kartu insight
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
                // Aksi untuk Opsi 1
                Navigator.of(context).pop(); // Menutup dialog
                print('Opsi 1 dipilih');
              },
            ),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Opsi 2'),
              onTap: () {
                // Aksi untuk Opsi 2
                Navigator.of(context).pop(); // Menutup dialog
                print('Opsi 2 dipilih');
              },
            ),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Opsi 3'),
              onTap: () {
                // Aksi untuk Opsi 3
                Navigator.of(context).pop(); // Menutup dialog
                print('Opsi 3 dipilih');
              },
            ),
          ],
        ),
      );
    },
  );
}
