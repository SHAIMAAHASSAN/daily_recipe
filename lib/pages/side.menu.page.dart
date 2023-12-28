import 'package:daily_recipe/pages/recently_view.Page.dart';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/services/preference.services.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:flutter/material.dart';

class SideMenuPage extends StatefulWidget {
  const SideMenuPage({super.key});

  @override
  State<SideMenuPage> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage> {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      ImagesPath.profile,
                    ),
                  ),
                  title:
                      Text("${PreferencService.prefs?.getString("username")}"),
                  subtitle: Text("View Profile"),
                  trailing: IconButton(
                      onPressed: () {}, icon: Icon(Icons.notifications)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                    Text("Home"),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.favorite_border)),
                    Text("Favorites"),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecentlyViewedPage(),
                        ));
                  },
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.play_arrow_outlined)),
                      Text("Recently Viewed"),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                    Text("Settings"),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.info_outline_rounded)),
                    Text("About Us"),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.help_outline)),
                    Text("Help"),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    //  color= Colors.deepOrange;
                    // setState(){};
                    PreferencService.logout();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StartPage(),
                        ));
                  },
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.exit_to_app_sharp)),
                      Text(
                        "Sign Out",
                        style: TextStyle(color: color),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 90,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
