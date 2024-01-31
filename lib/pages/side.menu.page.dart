import 'package:daily_recipe/pages/favorite.page.dart';
import 'package:daily_recipe/pages/filtter.page.dart';
import 'package:daily_recipe/pages/home.page.dart';
import 'package:daily_recipe/pages/profile.page.dart';
import 'package:daily_recipe/pages/recently_view.Page.dart';
import 'package:daily_recipe/pages/settings.page.dart';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/provider/auth.Provider.dart';
import 'package:daily_recipe/services/preference.services.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/widgets/list.item.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../utils/navigation.utils.dart';
import 'my.kitchen.page.dart';

class SideMenuPage extends StatefulWidget {
  const SideMenuPage({super.key});

  @override
  State<SideMenuPage> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage> {

  bool  isSelected = false;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    return GestureDetector(
      onDoubleTap: () =>
          NavigationUtils.push(context: context, page: SideMenuPage()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL! ),
                      ),
                      title: Text(
                          "${FirebaseAuth.instance.currentUser!.displayName}"),
                      // "${FirebaseAuth.instance.currentUser!.displayName}"),
                      //${GetIt.I.get<SharedPreferences>().getString("name")}
                      subtitle: Text("View Profile"),
                      /*trailing: IconButton(
                          onPressed: () {}, icon: Icon(Icons.notifications)),*/
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
          ListItem(title: "Home", leadingIcon: Icons.home,
            page:HomePage(),),
          ListItem(title: "Favorites", leadingIcon: Icons.favorite_outline_sharp,
            page:FavoritePage(),),
          ListItem(title: "RecentlyViewed", leadingIcon: Icons.play_arrow_outlined,
              page:RecentlyViewedPage( )),

          ListItem(title: "My Kitchen", leadingIcon: Icons.kitchen,
              page:MyKitchenPage()),
                  ListItem(title: "Filtter", leadingIcon: Icons.tune_sharp,
                      page:FiltterPage()),
                  ListItem(title: "Setting", leadingIcon: Icons.settings,
                      page:SettingsPage()),
                  ListItem(title: "Profile", leadingIcon: Icons.person,
                      page:ProfilePage()),
          GestureDetector(
            onTap: () {
              setState(() {
                isSelected = !isSelected;
              });
              Provider.of<AuthProviderViewModel>(context,listen: false).signOut(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                leading: Icon(Icons.exit_to_app_outlined, color: isSelected ? Colors.deepOrange : Colors.grey),
                title: Text("SignOut", style: TextStyle(color: isSelected ? Colors.deepOrange
                    : Colors.grey,fontSize: 18)),
              ),
            ),
          ),
                // SizedBox(height: 50,)
                 Spacer(),


                 /* GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = !selected;
                      });


                      NavigationUtils.push(context: context, page: HomePage());
                    },
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.home,
                          ),
                          color: selected ? orangeColor : blackColor,

                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                              color: selected ? orangeColor : blackColor),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                       selected = !selected;
                      });

                      NavigationUtils.push(
                          context: context, page: FavoritePage());
                    },
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_border),
                          color: selected ? orangeColor : blackColor,
                        ),
                        Text(
                          "Favorites",
                          style: TextStyle(
                              color: selected ? orangeColor : blackColor),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = !selected;
                      });


                      NavigationUtils.push(
                          context: context, page: RecentlyViewedPage());
                    },
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.play_arrow_outlined),
                          color: selected ? orangeColor : blackColor,
                        ),
                        Text(
                          "Recently Viewed",
                          style: TextStyle(
                              color: selected ? orangeColor : blackColor),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selected = !selected;


                      NavigationUtils.push(
                          context: context, page: MyKitchenPage());
                    },
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.kitchen_rounded),
                          color: selected ? orangeColor : blackColor,
                        ),
                        Text(
                          "My Kitchen",
                          style: TextStyle(
                              color: selected ? orangeColor : blackColor),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = !selected;
                      });


                    },
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.settings),
                          color: selected ? orangeColor : blackColor,
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
                              color: selected ? orangeColor : blackColor),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = !selected;
                      });


                    },
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.info_outline_rounded),
                          color: selected ? orangeColor : blackColor,
                        ),
                        Text(
                          "About Us",
                          style: TextStyle(
                              color: selected ? orangeColor : blackColor),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () { setState(() {
                      selected = !selected;
                    });
                   },
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.help_outline),
                          color: selected ? orangeColor : blackColor,
                        ),
                        Text(
                          "Help",
                          style: TextStyle(
                              color: selected ? orangeColor : blackColor),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = !selected;
                      });



                       GetIt.I.get<SharedPreferences>().remove("name");
                      GetIt.I.get<SharedPreferences>().remove("isLogin");

                      Provider.of<AuthProviderViewModel>(context, listen: false)
                          .signOut(context);
                      FirebaseAuth.instance.authStateChanges().listen((user) {
                        print(
                            "===========================user=$user===========================");
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
                          icon: Icon(Icons.exit_to_app_sharp),
                          color: selected ? orangeColor : blackColor,
                        ),
                        Text(
                          "Sign Out",
                          style: TextStyle(
                              color: selected ? orangeColor : blackColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
