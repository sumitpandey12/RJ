import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserDocUpload extends StatefulWidget {
  const UserDocUpload({Key? key}) : super(key: key);

  @override
  _UserDocUploadState createState() => _UserDocUploadState();
}

class _UserDocUploadState extends State<UserDocUpload> {
  File? _profileImage;
  String? _aadharNumber;
  File? _aadharFront;
  File? _aadharBack;

  bool get _isFormValid =>
      _profileImage != null &&
      _aadharNumber != null &&
      _aadharFront != null &&
      _aadharBack != null;

  Future<void> _getImageFromGallery() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  Future<void> _getAadharFrontFromGallery() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _aadharFront = File(image.path);
      });
    }
  }

  Future<void> _getAadharFrontFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _aadharFront = File(pickedFile.path);
      }
    });
  }

  Future<void> _getAadharBackFromGallery() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _aadharBack = File(image.path);
      });
    }
  }

  Future<void> _getAadharBackFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _aadharBack = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document Upload"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select an option'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            GestureDetector(
                              child: Text('Click a photo'),
                              onTap: () {
                                _getImageFromCamera();
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              child: Text('Upload from phone'),
                              onTap: () {
                                _getImageFromGallery();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Stack(
                children: [
                  Container(
                    height: 125.0,
                    width: 125.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2.5,
                      ),
                    ),
                    child: _profileImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              _profileImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Text(
                              "Add Profile Photo",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                  ),
                  Positioned(
                    left: 0,
                    top: 85,
                    child: _profileImage == null
                        ? Icon(
                            Icons.add_circle,
                            size: 30.0,
                          )
                        : Container(),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Aadhar Number",
                border: UnderlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _aadharNumber = value.trim().isNotEmpty ? value.trim() : null;
                });
              },
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select an option'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            GestureDetector(
                              child: Text('Click a photo'),
                              onTap: () {
                                _getAadharFrontFromCamera();
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              child: Text('Upload from phone'),
                              onTap: () {
                                _getAadharFrontFromGallery();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1.0,
                      blurRadius: 1.0,
                      offset: Offset(0, 1),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      _aadharFront == null ? Icons.upload_file : Icons.done,
                      color: _aadharFront == null ? Colors.black : Colors.green,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'ADD E AADHAR(Front Side)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select an option'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            GestureDetector(
                              child: Text('Click a photo'),
                              onTap: () {
                                _getAadharBackFromCamera();
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              child: Text('Upload from phone'),
                              onTap: () {
                                _getAadharBackFromGallery();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1.0,
                      blurRadius: 1.0,
                      offset: Offset(0, 1),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      _aadharBack == null ? Icons.upload_file : Icons.done,
                      color: _aadharBack == null ? Colors.black : Colors.green,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'ADD E AADHAR(Back Side)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _isFormValid
                  ? () {
                      // Navigate to the next screen
                    }
                  : null,
              child: Text("Finish"),
            ),
          ],
        ),
      ),
    );
  }
}
