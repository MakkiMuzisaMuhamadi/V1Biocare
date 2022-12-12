import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:v1biocare/Screens/Prescriptions/uploadPrescription.dart';
import 'package:v1biocare/Widgets/CustomAppbar.dart';

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});
  static const String id = 'prescriptions-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Prescriptions'),
      bottomSheet: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 5, 5, 10),
          child: Row(
            children: [
              Text(
                'Need help With your Medication? \n Our Pharmacists are available 24/7.',
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 4, 37, 64)),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          // ignore: sort_child_properties_last
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UploadPrescription(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 213, 234, 244),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/rx_yes.png'),
                    Align(
                      alignment: Alignment.center,
                      child: const Text(
                        'I have  Prescription',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print('muzisa');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 213, 234, 244),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/rx_no.png'),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 5, 3),
                        child: const Text(
                          'I Dont  have  Prescription',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print('muzisa');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 213, 234, 244),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/call.png'),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 5, 3),
                        child: const Text(
                          'Call Now',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print('muzisa');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 213, 234, 244),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/chat.png'),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 5, 3),
                        child: const Text(
                          'Chat Now',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
          ),
        ),
      ),
    );
  }
}
