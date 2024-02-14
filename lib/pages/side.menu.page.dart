import 'package:daily_recipe/pages/favorite.page.dart';
import 'package:daily_recipe/pages/filter.page.dart';
import 'package:daily_recipe/pages/home.page.dart';
import 'package:daily_recipe/pages/profile.page.dart';
import 'package:daily_recipe/pages/recently_view.Page.dart';
import 'package:daily_recipe/pages/settings.page.dart';
import 'package:daily_recipe/provider/auth.Provider.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/widgets/list.item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my.kitchen.page.dart';

class SideMenuPage extends StatefulWidget {
  const SideMenuPage({super.key});

  @override
  State<SideMenuPage> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage> {
  bool isSelected = false;
  String image =
      "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg";
  String? photo = FirebaseAuth.instance.currentUser!.photoURL;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () =>
          NavigationUtils.push(context: context, page: const SideMenuPage()),
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: photo != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                  FirebaseAuth.instance.currentUser!.photoURL!))
                          : CircleAvatar(backgroundImage: NetworkImage(image)),
                      title: Text(
                          "${FirebaseAuth.instance.currentUser!.displayName}"),
                      subtitle: InkWell(
                          onTap: () => NavigationUtils.push(
                              context: context, page: const ProfilePage()),
                          child: const Text("View Profile").tr()),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const ListItem(
                    title: "Home",
                    leadingIcon: Icons.home,
                    page: HomePage(),
                  ),
                  const ListItem(
                    title: "Favorites",
                    leadingIcon: Icons.favorite_outline_sharp,
                    page: FavoritePage(),
                  ),
                  const ListItem(
                      title: "RecentlyViewed",
                      leadingIcon: Icons.play_arrow_outlined,
                      page: RecentlyViewedPage()),

                  const ListItem(
                      title: "My Kitchen",
                      leadingIcon: Icons.kitchen,
                      page: MyKitchenPage()),
                  const ListItem(
                      title: "Filter",
                      leadingIcon: Icons.tune_sharp,
                      page: FilterPage()),
                  const ListItem(
                      title: "Settings",
                      leadingIcon: Icons.settings,
                      page: SettingsPage()),
                  const ListItem(
                      title: "Profile",
                      leadingIcon: Icons.person,
                      page: ProfilePage()),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected = !isSelected;
                      });
                      Provider.of<AuthProviderViewModel>(context, listen: false)
                          .signOut(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListTile(
                        leading: Icon(Icons.exit_to_app_outlined,
                            color: isSelected
                                ? Colors.deepOrange
                                : Colors.black54),
                        title: Text("SignOut",
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.deepOrange
                                        : Colors.grey,
                                    fontSize: 16))
                            .tr(),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
