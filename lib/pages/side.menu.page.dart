import 'package:daily_recipe/pages/favorite.page.dart';
import 'package:daily_recipe/pages/home.page.dart';
import 'package:daily_recipe/pages/recently_view.Page.dart';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/provider/auth.Provider.dart';
import 'package:daily_recipe/services/preference.services.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../utils/navigation.utils.dart';

class SideMenuPage extends StatefulWidget {
  const SideMenuPage({super.key});

  @override
  State<SideMenuPage> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage> {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    return GestureDetector(
      onTap: ()=>   NavigationUtils.push(context: context, page:SideMenuPage()),
      child: Scaffold(

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(15),

                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          ImagesPath.profile,
                        ),
                      ),
                      title:
                          Text("${FirebaseAuth.instance.currentUser!.displayName}"),
                             // "${FirebaseAuth.instance.currentUser!.displayName}"),
                      //${GetIt.I.get<SharedPreferences>().getString("name")}
                      subtitle: Text("View Profile"),
                      /*trailing: IconButton(
                          onPressed: () {}, icon: Icon(Icons.notifications)),*/
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (){

                      NavigationUtils.push(context: context, page: HomePage());

                    },
                    child: Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                        Text("Home"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigationUtils.push(context: context, page: FavoritePage());
                    },
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {

                            }, icon: Icon(Icons.favorite_border)),
                        Text("Favorites"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigationUtils.push(context: context, page: RecentlyViewedPage());

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

                     /* GetIt.I.get<SharedPreferences>().remove("name");
                      GetIt.I.get<SharedPreferences>().remove("isLogin");*/

                      Provider.of<AuthProviderViewModel>(context,listen: false).signOut(context);
                         FirebaseAuth.instance.authStateChanges().listen((user) {

                print("===========================user=$user===========================");
              });
                    //  if(mounted){Provider.of<AuthProviderViewModel>(context,listen: false).signOut(context);
                     // };

                      //PreferencService.logout();
                     // NavigationUtils.push(context: context, page: StartPage());

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
      ),
    );
  }
}
