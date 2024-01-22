import 'package:daily_recipe/pages/notification.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/widgets/header.bar.dart';
import 'package:daily_recipe/widgets/search.bar.dart';
import 'package:flutter/material.dart';

class RecentlyViewedPage extends StatelessWidget {
  const RecentlyViewedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /*appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SideMenuPage(),
                    ));
              },
              icon: Icon(Icons.sort)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationPage(),
                      ));
                },
                icon: Icon(Icons.notifications)),
          ]),*/
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderBar(title: "Recently Viewed", titleRight: "Clear"),
                SizedBox(
                  height: 20,
                ),
                SearchBarEX(hintText: "Search Using Keywords"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
