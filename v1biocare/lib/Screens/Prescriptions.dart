// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:v1biocare/Screens/profileScreen.dart';

class PRescriptionsScreen extends StatefulWidget {
  const PRescriptionsScreen({super.key});

  static const String id = 'prescription-Screen';
  @override
  State<PRescriptionsScreen> createState() => _PRescriptionsScreenState();
}

class _PRescriptionsScreenState extends State<PRescriptionsScreen> {
  CollectionReference userprescriptionCollection =
      FirebaseFirestore.instance.collection('user_prescription');
  User? user = FirebaseAuth.instance.currentUser;
  QuerySnapshot? snapshot;

  Widget prescriptionCard(data) {
    return Card(
      color: Colors.grey.shade400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 150,
              width: 180,
              child: Image.network(
                data['image'],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prescriptions',
          style: TextStyle(letterSpacing: 2),
        ),
        backgroundColor: Colors.green,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(context, ProfileScreen.id);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userprescriptionCollection
            .where('uid', isEqualTo: user!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          if (snapshot.data!.size == 0) {
            return const Text('No Prescriptions Added');
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 3,
              //To be Removed to create picture card
              // childAspectRatio: 6 / 2,
              crossAxisCount: 5,
              mainAxisSpacing: 3,
            ),
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index];
              return prescriptionCard(data);
            },
          );
        },
      ),
    );
  }
}
