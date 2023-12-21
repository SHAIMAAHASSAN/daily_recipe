import 'package:daily_recipe/pages/login.page.dart';
import 'package:flutter/material.dart';

import '../services/preference.services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
   /* String data = "";
    PreferencService.loginNameData().then((fetchedData) {
      setState(() {
        data = fetchedData;
         print("===========data:$data=============");
      });
    });*/

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          actions: [
            IconButton(
                onPressed: () async {
                  PreferencService.logout();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                  var email = await PreferencService.loginData();
                  print("output======> $email ========>");
                },
                icon: Icon(Icons.logout_rounded)),

            IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Good Morning,"),
        ),
      ),
    );
  }
}
