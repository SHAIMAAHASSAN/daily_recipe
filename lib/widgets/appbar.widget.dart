import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../pages/notification.page.dart';
import '../pages/side.menu.page.dart';
class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key,required this .title,required this.color});
  final String title;
  final Color color;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  late ZoomDrawerController controller;
  @override
  void initState() {

    controller = ZoomDrawerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return /*ZoomDrawer(
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
    body:*/
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          color: widget.color,
        onPressed: () {
        print("""""""""""""""""""""""""""object""""""""""""""""""""""""""");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SideMenuPage(),
          ));
    },
    icon: Icon(Icons.sort)),

        Text(widget.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: widget.color,fontFamily: "AbrilFatface"),),
        IconButton(
            color: widget.color,
            onPressed: () {
              print("""""""""""""""""""""""""""object""""""""""""""""""""""""""");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationPage(),
                  ));
            },
            icon: Icon(Icons.notifications)),

      ],
  //  ),)

    );



  }
}
