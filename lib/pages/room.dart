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
      final localizations = AppLocalizations.of(context)!;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(localizations.checkIn),
          content: Text(
            localizations
                .confirmCheckIn(selectedRoom!)
                .replaceFirst('{roomId}', selectedRoom!),
          ),
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
        ),
      );
    }
  }

  void handleCheckOut() {
    if (selectedRoom != null) {
      final localizations = AppLocalizations.of(context)!;
      if (roomStatuses[selectedRoom!] == RoomStatus.occupied) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(localizations.checkOut),
            content: Text(localizations
                .confirmCheckOut(selectedRoom!)
                .replaceFirst('{roomId}', selectedRoom!)),
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
        (roomStatuses[selectedRoom!] == RoomStatus.needsAttention ||
            roomStatuses[selectedRoom!] == RoomStatus.needsCleaning)) {
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
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildLegendItem(localizations.available, Colors.green),
                        _buildLegendItem(localizations.occupied, Colors.grey),
                        _buildLegendItem(
                            localizations.needsAttention, Colors.red),
                        _buildLegendItem(
                            localizations.needsCleaning, Colors.orange),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          localizations.floor('$selectedFloor'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: List.generate(10, (index) {
                            final roomId =
                                'R${(selectedFloor - 1) * 10 + index + 1}';
                            return SizedBox(
                              width: MediaQuery.of(context).size.width / 3 - 24,
                              child: RoomTile(
                                roomId: roomId,
                                isSelected: selectedRoom == roomId,
                                status: roomStatuses[roomId]!,
                                onTap: () => handleRoomTap(roomId),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    children: List.generate(4, (index) {
                      final floor = index + 1;
                      return Card(
                        child: InkWell(
                          onTap: () => selectFloor(floor),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 2,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              localizations.floor('$floor'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: floor == selectedFloor
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: handleCheckIn,
                  icon: const Icon(Icons.login),
                  label: Text(localizations.checkIn),
                ),
                ElevatedButton.icon(
                  onPressed: handleCheckOut,
                  icon: const Icon(Icons.logout),
                  label: Text(localizations.checkOut),
                ),
                ElevatedButton.icon(
                  onPressed: handleCleaning,
                  icon: const Icon(Icons.cleaning_services),
                  label: Text(localizations.needsCleaning),
                ),
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
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

class RoomTile extends StatelessWidget {
  final String roomId;
  final bool isSelected;
  final RoomStatus status;
  final VoidCallback onTap;

  const RoomTile({
    super.key,
    required this.roomId,
    required this.isSelected,
    required this.status,
    required this.onTap,
  });

  Color _getBackgroundColor() {
    if (isSelected) {
      return Colors.blue.withOpacity(0.3);
    }
    switch (status) {
      case RoomStatus.available:
        return Colors.green;
      case RoomStatus.occupied:
        return Colors.grey;
      case RoomStatus.needsAttention:
        return Colors.red;
      case RoomStatus.needsCleaning:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              roomId,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
