import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:v1biocare/Screens/Screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v1biocare/models/productModel.dart';
import 'package:v1biocare/providers/check_out_provider.dart';
import 'package:v1biocare/providers/product_provider.dart';
import 'package:v1biocare/providers/review_cart_provider.dart';
import 'package:v1biocare/providers/wishlist_provider.dart';

import 'Screens/Prescriptions/PrescriptionUpload.dart';
import 'Screens/SearchPage.dart';
import 'firebaseServices/firebase_auth_methods.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ProductModel(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
        ChangeNotifierProvider<CheckoutProvider>(
          create: (context) => CheckoutProvider(),
        ),
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BioCare',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      builder: EasyLoading.init(),
      //  SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        Prescription.id: (context) => const Prescription(),
        // PRescriptionsScreen.id: (context) => const PRescriptionsScreen(),
        OnbordingScreen.id: (context) => const OnbordingScreen(),
        LoginPage.id: (context) => const LoginPage(),
        Register.id: (context) => Register(),
        MainScreen.id: (context) => const MainScreen(),
        ReviewCart.id: (context) => ReviewCart(),
        ProfileScreen.id: (context) => const ProfileScreen(),
        CategoriesScreen.id: (context) => const CategoriesScreen(),
        // Search.id: (context) => Search(),
      },
    );
  }
}
