import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jap_icons/medical_icons_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'Screens.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});
  static const String id = 'onboard-Screen';

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  double scrollerPosition = 0;
  final store = GetStorage();

  onButtonPressed(context) {
    store.write('onboarding', true);
    return Navigator.pushReplacementNamed(context, LoginPage.id);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (val) {
              setState(() {
                scrollerPosition = val.toDouble();
              });
            },
            children: [
              onboardPage(
                textColumn: Column(
                  mainAxisSize: MainAxisSize.min,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      MedicalIcons.ambulance,
                      size: 150,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'ORDER MEDICINE & \n HEALTH PRODUCTS  ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Navigate our user-friendly app to \n select and order all your medicines,\nhealth and beauty products\n and more',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              onboardPage(
                textColumn: Column(
                  mainAxisSize: MainAxisSize.min,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      CupertinoIcons.cloud_upload,
                      color: Colors.green,
                      size: 150,
                    ),
                    const Text(
                      'UPLOAD YOUR PRESCRIPTION & \n INSURANCE CLAIMS  ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'No need to wait in line use our new \n feature to upload photos of your  \n prescription and insurance card and \n we will deliver right to your doorstep',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              onboardPage(
                textColumn: Column(
                  mainAxisSize: MainAxisSize.min,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      CupertinoIcons.money_dollar_circle_fill,
                      color: Colors.green,
                      size: 150,
                    ),
                    const Text(
                      'PAYMENTS OPTIONS & \n LOYALTY PROGRAMS  ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Choose to pay via cash on delivery or \n card on delivery. Collect reward points on  \n all purchases and easily redeem them \n with our built in loyalty program',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              onboardPage(
                textColumn: Column(
                  mainAxisSize: MainAxisSize.min,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      CupertinoIcons.car_detailed,
                      color: Colors.green,
                      size: 150,
                    ),
                    const Text(
                      '24/7 DELIVERY  \n SERVICE  ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Our Pharmacists will prepare \n and dispatch your order in our  \n specially cooled vehicles \n within 30-90 minutes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              onboardPage(
                textColumn: Column(
                  mainAxisSize: MainAxisSize.min,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      CupertinoIcons.location_circle,
                      color: Colors.green,
                      size: 150,
                    ),
                    const Text(
                      'TRUCK YOUR ORDER & \n ORDER HISTORY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Track the status of your current \n order or view your previous \n orders in the history section of \n our app',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DotsIndicator(
                  dotsCount: 5,
                  position: scrollerPosition,
                  decorator: const DotsDecorator(activeColor: Colors.green),
                ),
                scrollerPosition == 4
                    ? MaterialButton(
                        onPressed: () {
                          onButtonPressed(context);
                        },
                        color: Colors.blueAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : MaterialButton(
                        onPressed: () {
                          onButtonPressed(context);
                        },
                        color: const Color.fromARGB(255, 44, 42, 42),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class onboardPage extends StatelessWidget {
  final Column? textColumn;
  const onboardPage({super.key, this.textColumn});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Center(child: textColumn),
        ),
      ],
    );
  }
}
