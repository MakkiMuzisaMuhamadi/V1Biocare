import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../utils/isloggedin.dart';
import 'Screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String id = 'splash-Screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final store = GetStorage();

  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      (() {
        // ignore: no_leading_underscores_for_local_identifiers
        bool? _boarding = store.read('onboarding');
        final firebaseUser = Provider.of<User?>(context, listen: false);

        if (_boarding == null) {
          Navigator.pushReplacementNamed(context, OnbordingScreen.id);
        } else if (_boarding == true) {
          Navigator.pushReplacementNamed(context, LoginPage.id);
        }
        if (firebaseUser != null) {
          Navigator.pushReplacementNamed(context, MainScreen.id);
        }

        _boarding == null
            ? Navigator.pushReplacementNamed(context, OnbordingScreen.id)
            : _boarding == true
                ? Navigator.pushReplacementNamed(context, LoginPage.id)
                : Navigator.pushReplacementNamed(context, OnbordingScreen.id);
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo.jpg'),
      ),
    );
  }
}
