import 'package:daily_recipe/pages/start.page.dart';
import 'package:flutter/material.dart';

import '../services/preference.services.dart';
import 'home.page.dart';
class SplahScreen extends StatefulWidget {
  const SplahScreen({super.key});

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {

  @override
  void initState() {
    initSplash();
    super.initState();
  }

  void initSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    if (PreferencService.isLoggedIn()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
      // go to home page
    } else {

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => StartPage()));
      // go to login page
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            //opacity: 0.2,
            image: AssetImage(
              'assets/images/background.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
