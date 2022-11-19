import 'package:flutter/material.dart';

class GlobalMethods {
  static NavigateTo({
    required BuildContext context,
    required String routeName,
  }) {
    Navigator.pushNamed(context, routeName);
  }
}
