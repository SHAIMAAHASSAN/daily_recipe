
import 'package:daily_recipe/pages/notification.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/widgets/ads.Carousal.dart';
import 'package:daily_recipe/widgets/header.bar.dart';
import 'package:daily_recipe/widgets/fresh.recipes.widget.dart';
import 'package:daily_recipe/widgets/recommended.recipes.widget.dart';
import 'package:daily_recipe/widgets/search.bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import '../provider/auth.Provider.dart';
import '../utils/navigation.utils.dart';
import 'filter.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ZoomDrawerController controller;

  @override
  void initState() {

    controller = ZoomDrawerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      slideWidth: MediaQuery.of(context).size.width * 0.75,
      menuBackgroundColor: Colors.white,
      boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
      disableDragGesture: true,
      mainScreenTapClose: true,
      showShadow: true,
      controller: controller,
      drawerShadowsBackgroundColor: Colors.grey,
      menuScreen: const SideMenuPage(),
      mainScreen: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: false,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              leading: IconButton(
                  onPressed: () {
                    controller.toggle!();
                  },
                  icon: const Icon(Icons.sort)),
              actions: [
                IconButton(
                    onPressed: () {
                      NavigationUtils.push(
                          context: context, page: const NotificationPage());
                    },
                    icon: const Icon(Icons.notifications)),
              ],
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            //scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      " Good Morning, ",
                      style: TextStyle(color: Colors.deepOrange),
                    ).tr(),
                    Text(
                      " ${FirebaseAuth.instance.currentUser!.displayName} .",
                      style: const TextStyle(color: Colors.deepOrange),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "What would you like to cook today ?",
                  style: TextStyle(
                      fontFamily: "AbrilFatface",
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic),
                ).tr(),
                /*const SizedBox(
                  height: 10,
                ),
               SearchBarEX(hintText: "Search for recipes"),*/

                const SizedBox(
                  height: 20,
                ),
                const AdsCarousal(),
                const SizedBox(
                  height: 20,
                ),
                const HeaderBar(
                    title: "Today's Fresh Recipes", titleRight: "See All"),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    /*onTap: () => NavigationUtils.push(
                        context: context, page: const FiltterPage()),*/
                    child: SearchBarEX(hintText: "Search for recipes".tr())),
                const SizedBox(
                  height: 25,
                ),
                const FreshRecipesWidget(),
                const SizedBox(
                  height: 20,
                ),
                const HeaderBar(title: "Recommended", titleRight: "See All"),

                const RecommendedRecipesWidget(),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
