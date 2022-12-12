import 'package:flutter/material.dart';
import 'package:v1biocare/Screens/Prescriptions/PrescriptionUpload.dart';

import '../Widgets/category_widget.dart';
import '../Widgets/productWidget.dart';
import '../Widgets/widgets.dart';
import 'mainscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String id = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'BioCare',
      ),
      body: ListView(
        children: [
          const BannerWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Products',
                      style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const ProductmodelWidget(),
        ],
      ),
    );
  }
}
