import 'package:flutter/material.dart';

class GeneralAffair extends StatefulWidget {
  const GeneralAffair({super.key});

  @override
  State<GeneralAffair> createState() => _GeneralAffairState();
}

class _GeneralAffairState extends State<GeneralAffair> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("General Affair"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: TextField(
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}