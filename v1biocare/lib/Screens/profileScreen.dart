import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:v1biocare/Screens/Prescriptions.dart';
import 'package:v1biocare/Screens/loginScreen.dart';
import 'package:v1biocare/Screens/upload_prescription.dart';
import 'package:v1biocare/Screens/wish_list.dart';

import '../Widgets/text_widgets.dart';
import '../firebaseServices/firebase_auth_methods.dart';
import '../utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String id = 'profile-Screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final TextEditingController addressTextController =
      TextEditingController(text: "");

  @override
  void dispose() {
    addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authuser = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: usersCollection.doc(user!.uid).snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }
            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 65,
                                      child: const CircleAvatar(
                                        radius: 60,
                                        backgroundImage: AssetImage(
                                            "assets/blank-profile-picture-g81a7e618f_1280.png"),
                                      ),
                                    ),
                                    Positioned(
                                        top: 85,
                                        left: 60,
                                        child: RawMaterialButton(
                                          fillColor: Colors.red,
                                          elevation: 10,
                                          onPressed: () {},
                                          child: Icon(
                                            Icons.add_a_photo,
                                            color: Colors.white,
                                            // color: Colors.green,
                                          ),
                                          padding: EdgeInsets.all(10),
                                          shape: CircleBorder(),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      streamSnapshot.data!["username"],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      streamSnapshot.data!["PhoneNumber"],
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      streamSnapshot.data!["email"],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    // if (!authuser.emailVerified)
                                    //   TextButton(
                                    //     onPressed: () {
                                    //       context
                                    //           .read<FirebaseAuthMethods>()
                                    //           .sendEmailVerification(context);
                                    //     },
                                    //     child: Text(
                                    //       ' Verify Email:',
                                    //       style: TextStyle(color: Colors.blue),
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: Colors.grey),
                          _listTiles(
                              title: 'Addresses',
                              subtitle: 'My Subtilt',
                              icon: IconlyBold.profile,
                              onPressed: () async {
                                await _showAddressDialog(context);
                              },
                              color: Colors.black),
                          _listTiles(
                              title: 'Orders',
                              icon: IconlyBold.bag,
                              onPressed: () {},
                              color: Colors.black),
                          _listTiles(
                              title: 'Wishlist',
                              icon: IconlyLight.heart,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => WishLsit(),
                                ));
                              },
                              color: Colors.black),
                          _listTiles(
                              title: 'Prescriptions',
                              icon: IconlyLight.calendar,
                              onPressed: () {
                                // Navigator.pushReplacementNamed(
                                //     context, PRescriptionsScreen.id);
                              },
                              color: Colors.black),
                          _listTiles(
                              title: 'Viewed Items',
                              icon: IconlyLight.show,
                              onPressed: () {},
                              color: Colors.black),
                          _listTiles(
                              title: 'Chat',
                              icon: IconlyLight.call,
                              onPressed: () {},
                              color: Colors.black),
                          _listTiles(
                              title: 'Reported Issues',
                              icon: IconlyLight.info_square,
                              onPressed: () {},
                              color: Colors.black),
                          _listTiles(
                              title: 'Logout',
                              icon: IconlyLight.logout,
                              onPressed: () {
                                _showLogoutDialog(context);
                              },
                              color: Colors.black),
                        ]),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

Future<void> _showLogoutDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            const Text('Sign out')
          ],
        ),
        content: const Text('Do You Want To Sign Out!!'),
        actions: [
          TextButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: TextWidget(
              color: Colors.cyan,
              text: 'Cancel',
              textSize: 18,
            ),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            child: TextWidget(
              color: Colors.red,
              text: 'Ok',
              textSize: 18,
            ),
          ),
        ],
      );
    },
  );
}

Future<void> _showAddressDialog(BuildContext context) async {
  final TextEditingController addressTextController =
      TextEditingController(text: "");

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update'),
          content: TextField(
            onChanged: (value) {},
            controller: addressTextController,
            maxLines: 6,
            decoration: const InputDecoration(hintText: 'You Address'),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('Update'),
            )
          ],
        );
      });
}

Widget _listTiles({
  required String title,
  String? subtitle,
  required IconData icon,
  required Function onPressed,
  required Color color,
}) {
  return ListTile(
    title: TextWidget(
      color: color,
      text: title,
      textSize: 18,
      //isTitle: true,
    ),
    subtitle: TextWidget(
      color: color,
      text: subtitle == null ? "" : subtitle,
      textSize: 12,
    ),
    leading: Icon(icon),
    trailing: Icon(IconlyLight.arrow_right_2),
    onTap: () {
      onPressed();
    },
  );
}


// FirebaseAuth.instance.signOut().then((value) {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => LoginPage(),
//                   ));