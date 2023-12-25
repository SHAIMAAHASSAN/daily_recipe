import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/services/preference.services.dart';
import 'package:flutter/material.dart';
class SideMenuPage extends StatelessWidget {
  const SideMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(leading: CircleAvatar(backgroundImage:AssetImage ( "assets/images/img.png",),

                ),
                  title: Text("${PreferencService.prefs?.getString("username")}"),
                  subtitle: Text("View Profile"),
                  trailing: IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
                ),

                SizedBox(height:20,),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                    Text("Home"),
                  ],
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
                    Text("Favorites"),
                  ],
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow_outlined)),
                    Text("Recently Viewed"),
                  ],
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                    Text("Settings"),
                  ],
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.info_outline_rounded)),
                    Text("About Us"),
                  ],
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.help_outline)),
                    Text("Help"),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    PreferencService.logout();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StartPage(),
                        ));
                  },
                  child: Row(
                    children: [
                      IconButton(onPressed: () {


                      }, icon: Icon(Icons.exit_to_app_sharp)),
                      Text("Sign Out"),
                    ],
                  ),
                ),
                SizedBox(height: 90,)
              ],
            ),
          ),
        ),
      ),
    )
     ;
  }
}
