import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    await Future.delayed(const Duration(seconds: 5));
    //if (PreferencService.isLoggedIn()) {
    if (GetIt.I.get<SharedPreferences>().getBool("isLogin")?? false) {
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
            image: AssetImage(ImagesPath.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(ImagesPath.logo),
            ),
            Text(
              "Cooking Done The Easy Way",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
