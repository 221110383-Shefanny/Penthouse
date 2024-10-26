import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GeneralAffair extends StatefulWidget {
  const GeneralAffair({super.key});

  @override
  State<GeneralAffair> createState() => _GeneralAffairState();
}

class _GeneralAffairState extends State<GeneralAffair> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          _image = File(photo.path);
        });
      }
    } catch (e) {
      print('Error taking photo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("General Affair"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 400,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(500),
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 235, 199, 128),
                        focusColor: const Color.fromARGB(255, 235, 199, 128),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: 'Input Report',
                        hintStyle: TextStyle(color: Colors.black,),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 200,
                    child: InkWell(
                      onTap: _takePhoto,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _image == null ? Colors.red : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: _image == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Take Photo',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    
                  },
                  icon: const Icon(Icons.report),
                  label: const Text('Send Report'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}