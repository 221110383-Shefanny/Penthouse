import 'package:flutter/material.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  // Daftar barang dummy
  final List<Map<String, dynamic>> inventoryItems = [
    {'name': 'Laptop', 'quantity': 10},
    {'name': 'Meja', 'quantity': 5},
    {'name': 'Kursi', 'quantity': 20},
    {'name': 'Proyektor', 'quantity': 3},
    {'name': 'Printer', 'quantity': 4},
  ];

  // Fungsi untuk menambah barang
  void _addItem() {
    showDialog(
      context: context,
      builder: (context) {
        String itemName = '';
        int itemQuantity = 1;

        return AlertDialog(
          title: const Text('Tambah Barang'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nama Barang'),
                onChanged: (value) {
                  itemName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Jumlah'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  itemQuantity = int.tryParse(value) ?? 1;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (itemName.isNotEmpty) {
                  setState(() {
                    inventoryItems
                        .add({'name': itemName, 'quantity': itemQuantity});
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addItem, // Memanggil fungsi untuk menambah barang
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Daftar Barang",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: inventoryItems.length, // Jumlah barang
                itemBuilder: (context, index) {
                  final item = inventoryItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.inventory, color: Colors.teal),
                      title: Text(item['name']!), // Nama barang
                      subtitle:
                          Text('Jumlah: ${item['quantity']}'), // Jumlah barang
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
