import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/pages/register.page.dart';
import 'package:daily_recipe/services/preference.services.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              //opacity: 0.2,
              image: AssetImage(
                ImagesPath.background,
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
                  height: 200,
                ),
                Image(
                  width: 300,
                  image: AssetImage(ImagesPath.logo),
                  alignment: Alignment.center,
                )
                /* Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Daily Recipe",
                    // style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w400,fontSize: 40),
                       style: TextStyle(
                         color: Colors.white,
                        fontSize: 40,
                      ),
                        //textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),*/
                ,
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Cooking Done The Easy Way",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 250,
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
                      //SizedBox(height: 10,)
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
