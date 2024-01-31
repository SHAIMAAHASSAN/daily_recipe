import 'package:flutter/material.dart';

import '../pages/notification.page.dart';
import '../pages/side.menu.page.dart';
class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        ]);
  }
}
