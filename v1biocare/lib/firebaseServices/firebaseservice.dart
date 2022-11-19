// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference homebanner =
      FirebaseFirestore.instance.collection('homebanner');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  CollectionReference subcategory =
      FirebaseFirestore.instance.collection('subcategory');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  //add to cart

}
