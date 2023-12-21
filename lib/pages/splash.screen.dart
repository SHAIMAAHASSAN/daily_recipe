import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/pages/register.page.dart';
import 'package:daily_recipe/services/preference.services.dart';
import 'package:flutter/material.dart';

import 'home.page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initSplash();
    super.initState();
  }

  void initSplash() async {
    await Future.delayed(const Duration(seconds: 10));
    if (PreferencService.isLoggedIn()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
      // go to home page
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPage()));
      // go to login page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              //opacity: 0.2,
              image: AssetImage(
                'assets/images/download.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Daily Recipe",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                        //textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    "Cooking Done The Easy Way",
                    style: TextStyle(color: Colors.white54, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 300,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            //if (PreferencService.isLoggedIn()) {
                            // var email = await PreferencService.loginData();
                            // print("output======> $email ========>");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ));
                            //  }
                            // else {

                            //Navigator.push(
                            // context,
                            //  MaterialPageRoute(
                            //   builder: (context) => LoginPage(),
                            // ));
                            //  }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.restaurant_menu_sharp),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Register",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepOrange),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 220,
                        child: ElevatedButton(
                          onPressed: () {
                            //if (PreferencService.isLoggedIn()) {
                            // var email = await PreferencService.loginData();
                            // print("output======> $email ========>");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                            //  }
                            // else {

                            // Navigator.push(
                            // context,
                            //  MaterialPageRoute(
                            //  builder: (context) => LoginPage(),
                            //));
                            //  }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Icon(Icons.restaurant_menu_sharp),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
