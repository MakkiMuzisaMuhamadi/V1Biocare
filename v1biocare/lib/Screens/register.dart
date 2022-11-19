// ignore_for_file: dead_code

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../firebaseServices/firebase_auth_methods.dart';
import '../utils/showSnackbar.dart';
import '../utils/utils.dart';
import 'Screens.dart';

class Register extends StatefulWidget {
  static const String id = 'register-Screen';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  _RegisterState();
  String countryDial = "+256";

  bool showProgress = false;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpassController =
      new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final userRef = FirebaseFirestore.instance.collection("users");

  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;
  bool isloadin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          "Register Now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Username',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Username cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        IntlPhoneField(
                          controller: phoneController,
                          showCountryFlag: true,
                          showDropdownIcon: true,
                          initialValue: countryDial,
                          onCountryChanged: (country) {
                            setState(() {
                              countryDial = "+" + country.dialCode;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure2,
                          controller: confirmpassController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Confirm Password',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (confirmpassController.text !=
                                passwordController.text) {
                              return "Password did not match";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                CircularProgressIndicator();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            isloadin
                                ? CircularProgressIndicator()
                                : MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    elevation: 5.0,
                                    height: 40,
                                    onPressed: () async {
                                      final String username =
                                          usernameController.text.trim();
                                      final String number =
                                          phoneController.text.trim();
                                      final String email =
                                          emailController.text.trim();
                                      final String password =
                                          passwordController.text.trim();
                                      final String comfirmpassword =
                                          confirmpassController.text.trim();
                                      if (username.isEmpty) {
                                        Utils().toastMessage(
                                            'Please Fill Username !');
                                      }
                                      if (number.isEmpty) {
                                        Utils().toastMessage(
                                            'Phone number cannot be Empty!');
                                      }
                                      if (email.isEmpty) {
                                        Utils().toastMessage(
                                            'Email cannot be Empty!');
                                      } else {
                                        if (password.isEmpty) {
                                          Utils().toastMessage(
                                              'Password cannot be Empty!');
                                        }
                                        if (comfirmpassword != password) {
                                          Utils().toastMessage(
                                              'Password did not match!');
                                        } else {
                                          setState(() {
                                            isloadin = true;
                                          });
                                          context
                                              .read<FirebaseAuthMethods>()
                                              .signUpWithEmail(
                                                  context: context,
                                                  email: email,
                                                  password: password)
                                              .then((value) async {
                                            User? user = FirebaseAuth
                                                .instance.currentUser;
                                            await userRef.doc(user!.uid).set({
                                              'uid': user.uid,
                                              "username": username,
                                              "PhoneNumber":
                                                  countryDial + number,
                                              "email": email,
                                              // "PhoneNumber": phoneController,
                                            });
                                            setState(() {
                                              isloadin = false;
                                            });
                                          });
                                        }
                                      }
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Wrap(
                children: [
                  MaterialButton(
                    // color: Colors.blue[900],
                    shape: const RoundedRectangleBorder(
                        // side: BorderSide(color: Colors.black, width: 1),
                        ),
                    onPressed: () {},
                    child: const Text(
                      " By Clicking Sign Up you agree to our Terms of Service and that you have read our Privacy Policy",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//   void signUpUser() async {
//     context.read<FirebaseAuthMethods>().signUpWithEmail(
//           email: emailController.text,
//           password: passwordController.text,
//           context: context,
//         );
//   }
// }


//   signUp(String email, String password) async {
//     if (_formkey.currentState!.validate()) {
//       try {
//         final User? user =
//             (await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         ))
//                 .user;
    // if (user != null) {
      // userRef
      //     .doc(user.uid)
      //     .set({
      //       "username": usernameController.text.trim(),
      //       "MobileNumber": countryDial + phoneController.text.trim(),
      //       "email": emailController.text.trim(),
      //       // "PhoneNumber": phoneController,
      //     })
//               .then((value) => null)
//               .catchError((onError) {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => LoginPage(),
//                     ));
//               });
//         }
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'weak-password') {
//           print('The password provided is too weak.');
//         } else if (e.code == 'email-already-in-use') {
//           print('The account already exists for that email.');
//         }
//       } catch (e) {
//         print(e);
//       }
//     }

//     CircularProgressIndicator();
//   }
// }