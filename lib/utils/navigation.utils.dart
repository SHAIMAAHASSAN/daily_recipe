import 'package:flutter/material.dart';

abstract class NavigationUtils {
  static push({required BuildContext context, required Widget page}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  static pushReplacement({required BuildContext context, required Widget page}) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }
}