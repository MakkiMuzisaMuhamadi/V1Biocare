import 'package:flutter/material.dart';
import 'package:v1biocare/Screens/upload_prescription.dart';

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
          SizedBox(
            width: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Prescription(),
                          ),
                        );
                      },
                      color: Colors.green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Upload Prescription",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "My Doctor",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                //     Row(
                //       children: [
                //         InkWell(
                //           onTap: () {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (BuildContext context) =>
                //                     const MainScreen(index: 1),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             'View All',
                //             style: TextStyle(
                //                 color: Colors.green,
                //                 letterSpacing: 1,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 20),
                //           ),
                //         ),
                //       ],
                //     )
              ],
            ),
          ),
          const ProductmodelWidget(),
        ],
      ),
    );
  }
}
