import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/pages/register.page.dart';
import 'package:daily_recipe/services/preference.services.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/navigation.utils.dart';
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
      body:Container(
      decoration: BoxDecoration(
      image: DecorationImage(
        //opacity: 0.2,
        image: AssetImage(
        ImagesPath.background,
      ),
        fit: BoxFit.cover,
      ),
    ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0,top: 40,right: 40,left: 40),
            child: Image(

              image: AssetImage(ImagesPath.logo),
            //  alignment: Alignment.center,
            ),
          ),
          Text(
            "Cooking Done The Easy Way",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Spacer(),
          Container(
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                //if (PreferencService.isLoggedIn()) {
                // var email = await PreferencService.loginData();
                // print("output======> $email ========>");

                NavigationUtils.push(context: context, page:RegisterPage());

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
          SizedBox(height: 20,),
          Container(
            width: 220,
            child: ElevatedButton(
              onPressed: () {
                //if (PreferencService.isLoggedIn()) {
                // var email = await PreferencService.loginData();
                // print("output======> $email ========>");

                NavigationUtils.push(context: context, page: LoginPage());

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
          SizedBox(height: 10,)
        ],
      ),),
    );
  }
}
