import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:v1biocare/Screens/mainscreen.dart';
import 'dart:async';
import 'dart:io';

import 'uploadPrescription.dart';

class Prescription extends StatefulWidget {
  const Prescription({super.key});
  static const String id = 'upload-prescription';

  @override
  State<Prescription> createState() => _prescriptionState();
}

class _prescriptionState extends State<Prescription> {
  // pickImage() async {
  //   FilePickerResult? result = await FilePicker.platform
  //       .pickFiles(type: FileType.image, allowMultiple: false);
  //   if (result != null) {
  //     setState(() {
  //       image = result.files.single.bytes;
  //       filename = result.files.first.name;
  //     });
  //   } else {
  //     print('No file selected');
  //   }
  // }

  File? image;

  pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // openBottomSheet() {
  // Get.bottomSheet(
  //   Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(8), topRight: Radius.circular(8)),
  //     ),
  //     width: double.infinity,
  //     height: 150,
  //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
  //       buildImageWidget(
  //           iconData: Icons.camera_alt,
  //           onPressed: () {
  //             pickImage(ImageSource.camera);
  //           }),
  //       buildImageWidget(
  //           iconData: Icons.image,
  //           onPressed: () {
  //             pickImage(ImageSource.gallery);
  //           }),
  //     ]),
  //   ),
  // );
  // }

  @override
  Widget build(BuildContext context) {
    showBottomsheet() => showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 150,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.add_a_photo,
                    ),
                    title: Text('Camera'),
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.of(context).pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.browse_gallery_sharp,
                    ),
                    title: Text('Gallery'),
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.of(context).pop(context);
                    },
                  )
                ],
              ),
            ));
    Widget getImageWidget() {
      if (image != null) {
        return InkWell(
          onTap: () {
            showBottomsheet();
          },
          child: Image.file(
            image!,
            width: 90,
            height: 90,
            fit: BoxFit.cover,
          ),
        );
      } else {
        return Column(
          children: [
            InkWell(
              onTap: () {
                showBottomsheet();
              },
              child: Container(
                width: 70,
                height: 40,
                color: Colors.blue,
                child: Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Prescription"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Prescription Upload',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  MaterialButton(
                    child: Text(
                      "<  Back",
                      style: TextStyle(
                          color: Color.fromARGB(255, 40, 201, 250),
                          fontSize: 18),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UploadPrescription(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 1,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FittedBox(
                        child: Image.asset(
                          'assets/images/id.jpg',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Text(
                        'Uganda ID Front       ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      getImageWidget()
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FittedBox(
                        child: Image.asset(
                          'assets/images/id.jpg',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Text(
                        'Uganda ID Back Front',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 70,
                        height: 40,
                        color: Colors.blue,
                        child: Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        ),
                      )
                      // FittedBox(
                      //     child: Image.asset(
                      //   'assets/images/upload.png',
                      //   height: 90,
                      //   width: 90,
                      // ))
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FittedBox(
                        child: Image.asset(
                          'assets/images/insurance card.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Text(
                        'Insurance Card Front \n (optional)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 70,
                        height: 40,
                        color: Colors.blue,
                        child: Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        ),
                      )
                      // FittedBox(
                      //     child: Image.asset(
                      //   'assets/images/upload.png',
                      //   height: 90,
                      //   width: 90,
                      // ))
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FittedBox(
                        child: Image.asset(
                          'assets/images/insurance card.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Text(
                        'Insurance Card Back \n (optional)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 70,
                        height: 40,
                        color: Colors.blue,
                        child: Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        ),
                      )
                      // FittedBox(
                      //     child: Image.asset(
                      //   'assets/images/upload.png',
                      //   height: 90,
                      //   width: 90,
                      // ))
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FittedBox(
                        child: Image.asset(
                          'assets/images/insurance card.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Text(
                        'Insurance Card Front \n (optional)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 70,
                        height: 40,
                        color: Colors.blue,
                        child: Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        ),
                      )
                      // FittedBox(
                      //     child: Image.asset(
                      //   'assets/images/upload.png',
                      //   height: 90,
                      //   width: 90,
                      // ))
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FittedBox(
                      child: Image.asset(
                        'assets/images/note.jpg',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    Text(
                      'Prescription             ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 70,
                      height: 40,
                      color: Colors.blue,
                      child: Icon(
                        CupertinoIcons.add,
                        color: Colors.white,
                      ),
                    )
                    // FittedBox(
                    //     child: Image.asset(
                    //   'assets/images/upload.png',
                    //   height: 90,
                    //   width: 90,
                    // ))
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintText: 'Write the Notes',
                      hintStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.italic),
                    ),
                    maxLines: 3,
                  ),
                ),
                MaterialButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Color.fromARGB(255, 40, 201, 250), fontSize: 18),
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildImageWidget({required IconData iconData, required Function onPressed}) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(
            iconData,
            size: 30,
          ),
        ),
      ),
    );
  }
}
