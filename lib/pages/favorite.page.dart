import 'package:daily_recipe/pages/notification.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/widgets/search.bar.dart';
import 'package:flutter/material.dart';

import '../widgets/header.bar.dart';


class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
          leading: IconButton(
              onPressed: () {
               NavigationUtils.push(context: context, page: SideMenuPage()),

              },
              icon: Icon(Icons.sort)),
          actions: [
            IconButton(
                onPressed: () {
                 NavigationUtils.push(context: context, page: NotificationPage()),
                },
                icon: Icon(Icons.notifications)),
          ]),*/
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                HeaderBar(title:  "Favorites", titleRight:  ""),


                SizedBox(
                  height: 20,
                ),

                SearchBarEX(hintText: "Search Using Keywords",),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
