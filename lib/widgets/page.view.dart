import 'package:daily_recipe/pages/home.page.dart';
import 'package:daily_recipe/pages/notification.page.dart';
import 'package:daily_recipe/pages/recently_view.Page.dart';
import 'package:flutter/material.dart';

import '../pages/favorite.page.dart';
import '../pages/side.menu.page.dart';
import '../utils/navigation.utils.dart';
class PageViewPages extends StatefulWidget {
  const PageViewPages({super.key});

  @override
  State<PageViewPages> createState() => _PageViewPagesState();
}

class _PageViewPagesState extends State<PageViewPages> {

late PageController  controller;
bool showBtns = false;



void initListener() async {
  await Future.delayed(const Duration(milliseconds: 100));
  controller.addListener(() {
    setState(() {});
  });
}

void showBtnsFunc() async {
  await Future.delayed(const Duration(milliseconds: 120));
  showBtns = true;
  setState(() {});
}

ButtonStyle? buttonStyle(int index) {
  return (index == controller.page?.toInt())
      ? TextButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor:Colors.deepOrange):null;

}

void onTapOnBtn(int index) async {
  await controller.animateToPage(index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn);
      setState(() {});
}

  @override
  void initState() {
    // TODO: implement initState
    controller = PageController(initialPage: 0);
    initListener();
    showBtnsFunc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
               SliverAppBar(
                  pinned: false,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                 leading: IconButton(
                      onPressed: () {
                        NavigationUtils.push(
                            context: context, page: SideMenuPage());
                      },
                      icon: const Icon(Icons.sort)),
                  actions: [
                    IconButton(
                        onPressed: () {
                          NavigationUtils.push(
                              context: context, page: NotificationPage());
                        },
                        icon: const Icon(Icons.notifications)),
                  ],

                ),
              ];
            },

            body:Container(
              //  color: Colors.cyan,
                child:Column(
                  children: [
                    if(showBtns)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          TextButton(
                              style: buttonStyle(0),
                              onPressed: () => onTapOnBtn(0),
                              child: Text('Home')),
                          TextButton(
                              style: buttonStyle(1),
                              onPressed: () => onTapOnBtn(1),
                              child: Text('Recently views')),
                          TextButton(
                              style: buttonStyle(2),
                              onPressed: () => onTapOnBtn(2),
                              child: Text('Favorites')),
                        ],),
                    Expanded(
                      child: PageView(
                        controller:controller ,
                        children: const [
                          HomePage(),
                          RecentlyViewedPage(),
                          FavoritePage(),


                        ],
                      ),
                    ),
                  ],
                )


            ),
          ),
        ),
      )


    );
  }
}
