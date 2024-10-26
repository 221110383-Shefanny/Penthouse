import 'package:flutter/material.dart';

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
        builder: (context) => AlertDialog(
          title: Text('Check In Room ${selectedRoom!}'),
          content: const Text('Are you sure you want to check in this room?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  roomStatuses[selectedRoom!] = RoomStatus.occupied;
                  selectedRoom = null;
                });
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
    }
  }

  void handleCheckOut() {
    if (selectedRoom != null) {
      final currentStatus = roomStatuses[selectedRoom!];
      if (currentStatus == RoomStatus.occupied) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Check Out Room ${selectedRoom!}'),
            content: const Text('Are you sure you want to check out this room?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    roomStatuses[selectedRoom!] = RoomStatus.needsAttention;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Confirm'),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Room Management',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFFBE98),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFBE98).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Column(
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
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLegendItem('Available', Colors.green),
                      _buildLegendItem('Occupied', Colors.grey),
                      _buildLegendItem('Needs Attention', Colors.red),
                    ],
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
                    // Room List for Selected Floor with 3 Columns
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Floor $selectedFloor',
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
                    // Floor Selector on the Right with Green Border and White Background
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
                                'Floor $floor',
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
                    label: const Text('Check In'),
                  ),
                  ElevatedButton.icon(
                    onPressed: handleCheckOut,
                    icon: const Icon(Icons.logout),
                    label: const Text('Check Out'),
                  ),
                  ElevatedButton.icon(
                    onPressed: handleCleaning,
                    icon: const Icon(Icons.cleaning_services),
                    label: const Text('Cleaning'),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      case RoomStatus.needsCleaning:
        return Colors.red;
      case RoomStatus.needsAttention:
        return Colors.red;
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
