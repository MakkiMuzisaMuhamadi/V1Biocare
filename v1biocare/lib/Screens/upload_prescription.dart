import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
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

class Prescription extends StatefulWidget {
  const Prescription({super.key});
  static const String id = 'upload-prescription';

  @override
  State<Prescription> createState() => _prescriptionState();
}

class _prescriptionState extends State<Prescription> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final userRef = FirebaseFirestore.instance.collection("user_prescription");
  TextEditingController note = TextEditingController();
  Object? _selectedvalue;
  QuerySnapshot? snapshot;
  // dynamic image;
  String? filename;
  final _formkey = GlobalKey<FormState>();

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

  bool _inProcess = false;

  Widget getImageWidget() {
    if (image != null) {
      return Image.file(
        image!,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/placeholder.jpg",
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }

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

  saveImageToDb() async {
    EasyLoading.show();
    var ref = storage.ref('prescriptions/$filename');

    try {
      // String? mimiType = mime(
      //   basename(filename!),
      // );
      var metaData = firebase_storage.SettableMetadata();
      firebase_storage.TaskSnapshot uploadSnapshot =
          await ref.putFile(image!, metaData);
      String downloadURL =
          await uploadSnapshot.ref.getDownloadURL().then((value) {
        User? user = FirebaseAuth.instance.currentUser;
        if (value.isNotEmpty) {
          userRef.doc().set(
            {
              'uid': user!.uid,
              'note': note.text,
              'image': '$value.jpg',
              'active': true
            },
          ).then((value) {
            clear();
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Success! Wait For a Call  ');
          });
        }
        return value;
      });
    } on FirebaseException catch (e) {
      clear();
      print(e.toString());
    }
  }

  clear() {
    setState(() {
      note.clear();

      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Prescription',
          style: TextStyle(letterSpacing: 2),
        ),
        backgroundColor: Colors.green,
        // leading: BackButton(
        //   color: Colors.white,
        //   onPressed: () {
        //     Navigator.pushReplacementNamed(context, MainScreen.id);
        //   },
        // ),
      ),
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "To Upload Prescription follow below Instructions",
                              style: const TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 2,
                                  color: Colors.green,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Row(
                      children: [
                        Text(
                          'STEP 1:   UPLOAD IMAGE OF YOUR PRESCRIPTION',
                          style: const TextStyle(
                              letterSpacing: 2, color: Colors.green),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                // Container(
                //   height: 150,
                //   width: 150,
                //   decoration: BoxDecoration(
                //     color: Colors.grey.shade400,
                //     borderRadius: BorderRadius.circular(4),
                //     border: Border.all(color: Colors.grey.shade800),
                //   ),

                // ),
                getImageWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                        color: Colors.green,
                        child: Text(
                          "Select",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          pickImage(ImageSource.gallery);
                        }),
                    MaterialButton(
                        color: Colors.green,
                        child: Text(
                          "Camera",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          pickImage(ImageSource.camera);
                        })
                  ],
                ),
                Divider(
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Text(
                      'STEP 2:  Add Note',
                      style: const TextStyle(
                          letterSpacing: 2, color: Colors.green),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  controller: note,
                  decoration: const InputDecoration(
                      hintText: 'Add Note or Leave it Empty',
                      contentPadding: EdgeInsets.zero),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        'One of our Lincesed Pharmacist will\n be contacting you about your.\nFeel free to Leave any additional notes above. ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (image != null)
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          elevation: 5.0,
                          height: 40,
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              saveImageToDb();
                            }
                            ;
                          },
                          color: Colors.green,
                          child: Text(
                            "Send",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      // ElevatedButton(
                      //   onPressed: () {

                      //     if (_formkey.currentState!.validate()) {
                      //       saveImageToDb();
                      //     }
                      //   },
                      //   child: const Text(
                      //     'Send',
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
