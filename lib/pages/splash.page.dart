import 'dart:async';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.page.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({super.key});

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  StreamSubscription<User?>? listener;
  @override
  void initState() {
    initSplash();
    super.initState();
  }

  void initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    listener = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        NavigationUtils.pushReplacement(context: context, page: const HomePage());
      } else {
        NavigationUtils.pushReplacement(context: context, page: const StartPage());
      }
    });
  }

  @override
  void dispose() {
    listener?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
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
            const Text(
              "Cooking Done The Easy Way",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
