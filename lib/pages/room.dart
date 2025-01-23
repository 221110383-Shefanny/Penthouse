import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum RoomStatus {
  available,
  occupied,
  needsCleaning,
  needsAttention,
}

class RoomLayout extends StatefulWidget {
  const RoomLayout({super.key});

  @override
  State<RoomLayout> createState() => _RoomLayoutState();
}

class _RoomLayoutState extends State<RoomLayout> {
  String? selectedRoom;
  Map<String, RoomStatus> roomStatuses = {};
  int selectedFloor = 1;

  @override
  void initState() {
    super.initState();
    // Initialize room statuses for 4 floors with 10 rooms each.
    for (int floor = 1; floor <= 4; floor++) {
      for (int room = 1; room <= 10; room++) {
        String roomId = 'R${(floor - 1) * 10 + room}';
        roomStatuses[roomId] = RoomStatus.available;
      }
    }
  }

  void handleRoomTap(String roomId) {
    setState(() {
      selectedRoom = (selectedRoom == roomId) ? null : roomId;
    });
  }

  void handleCheckIn() {
    if (selectedRoom != null) {
      showDialog(
        context: context,
        builder: (context) {
          final localizations = AppLocalizations.of(context)!;
          return AlertDialog(
            title: Text(localizations.checkIn),
            content: Text(localizations.confirmCheckIn(selectedRoom!).replaceFirst('{roomId}', selectedRoom!)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(localizations.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    roomStatuses[selectedRoom!] = RoomStatus.occupied;
                    selectedRoom = null;
                  });
                  Navigator.pop(context);
                },
                child: Text(localizations.confirm),
              ),
            ],
          );
        },
      );
    }
  }

  void handleCheckOut() {
    if (selectedRoom != null) {
      final localizations = AppLocalizations.of(context)!;
      final currentStatus = roomStatuses[selectedRoom!];
      if (currentStatus == RoomStatus.occupied) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(localizations.checkOut),
            content: Text(localizations.confirmCheckOut(selectedRoom!)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(localizations.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    roomStatuses[selectedRoom!] = RoomStatus.needsAttention;
                  });
                  Navigator.pop(context);
                },
                child: Text(localizations.confirm),
              ),
            ],
          ),
        );
      }
    }
  }

  void handleCleaning() {
    if (selectedRoom != null &&
        roomStatuses[selectedRoom!] == RoomStatus.needsAttention) {
      setState(() {
        roomStatuses[selectedRoom!] = RoomStatus.available;
      });
    }
  }

  void selectFloor(int floor) {
    setState(() {
      selectedFloor = floor;
      selectedRoom = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.appTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFFBE98),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Legend Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegendItem(localizations.available, Colors.green),
                _buildLegendItem(localizations.occupied, Colors.grey),
                _buildLegendItem(localizations.needsAttention, Colors.red),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  localizations.floor('{floor}').replaceFirst('{floor}', '$selectedFloor'),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                // Display rooms
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
