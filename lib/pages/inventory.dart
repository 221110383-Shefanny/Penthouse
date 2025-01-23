import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/Sqllite.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import the localization package

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final datalite _dbHelper = datalite();
  List<Map<String, dynamic>> inventoryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final items = await _dbHelper.getInventory();
    setState(() {
      inventoryItems = items;
    });
  }

  void _addItem() {
    showDialog(
      context: context,
      builder: (context) {
        String itemName = '';
        int itemQuantity = 1;

        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.addItem), // Localized title
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.itemName), // Localized label
                onChanged: (value) {
                  itemName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.itemQuantity), // Localized label
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
                  _dbHelper.insertItem({
                    'name': itemName,
                    'quantity': itemQuantity,
                  }).then((_) {
                    _loadItems();
                    Navigator.of(context).pop();
                  });
                }
              },
              child: Text(AppLocalizations.of(context)!.save), // Localized button
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel), // Localized button
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
        title: Text(AppLocalizations.of(context)!.appTitle), // Localized title
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addItem, // Calling function to add item
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.inventoryList, // Localized header
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: inventoryItems.length, // Number of items
                itemBuilder: (context, index) {
                  final item = inventoryItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.inventory, color: Colors.teal),
                      title: Text(item['name']!), // Item name
                      subtitle: Text('Quantity: ${item['quantity']}'), // Item quantity
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
