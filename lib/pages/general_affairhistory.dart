import 'package:flutter/material.dart';

class GeneralAffairhistory extends StatefulWidget {
  const GeneralAffairhistory({super.key});

  @override
  State<GeneralAffairhistory> createState() => _GeneralAffairhistoryState();
}

class _GeneralAffairhistoryState extends State<GeneralAffairhistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "History General Affair",
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [],
        ),
      ),
    );
  }
}
