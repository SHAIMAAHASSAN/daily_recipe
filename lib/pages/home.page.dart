import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/pages/notification.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../services/preference.services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  //var listItems =[1,2,3,4,5];
  var listItems = [
    ImagesPath.pic2,
    ImagesPath.pic3,
    ImagesPath.pic4,
    ImagesPath.cinnamon,
    ImagesPath.salmon,
    ImagesPath.frenchToast,
  ];

  CarouselController carouselControllerEx = CarouselController();
  @override
  Widget build(BuildContext context) {
    /* String data = "";
    PreferencService.loginNameData().then((fetchedData) {
      setState(() {
        data = fetchedData;
         print("===========data:$data=============");
      });
    });*/

    return Scaffold(
      appBar: AppBar(
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
            /* IconButton(
                onPressed: () async {
                  PreferencService.logout();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StartPage(),
                      ));
                  var email = await PreferencService.loginData();
                  print("output======> $email ========>");
                },
                icon: Icon(Icons.logout_rounded)),*/

            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationPage(),
                      ));
                },
                icon: Icon(Icons.notifications)),
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " Good Morning, ${PreferencService.prefs?.getString("username")}",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "What would you like to cook today ?",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search for recipes",
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.shade600,
                              size: 20,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: EdgeInsets.all(10),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade100,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.tune_sharp),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      child: CarouselSlider(
                        carouselController: carouselControllerEx,
                        options: CarouselOptions(
                          height: 200.0,
                          animateToClosest: true,
                          viewportFraction: .8,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enlargeFactor: .3,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (index, _) {
                            currentIndex = index;
                            print("==========$currentIndex==========");
                            setState(() {});
                          },
                        ),
                        items: listItems.map(
                          (i) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration:
                                    BoxDecoration(color: Colors.brown[50]),
                                child: Image(
                                  image: AssetImage(listItems[currentIndex]),
                                ));
                          },
                        ).toList(),
                      ),
                    ),
                    Positioned(
                        left: 20,
                        top: 100,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            size: 40,
                            color: Colors.brown,
                          ),
                          onPressed: () async {
                            if (currentIndex > 0) {
                              await carouselControllerEx
                                  .animateToPage(currentIndex - 1);
                            } else {
                              await carouselControllerEx
                                  .animateToPage(listItems.length - 1);
                            }
                          },
                        )),
                    Positioned(
                        right: 20,
                        top: 100,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_outlined,
                            size: 40,
                            color: Colors.brown,
                          ),
                          onPressed: () async {
                            if (currentIndex < listItems.length - 1) {
                              await carouselControllerEx
                                  .animateToPage(currentIndex + 1);
                            } else {
                              await carouselControllerEx.animateToPage(0);
                            }
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: DotsIndicator(
                    dotsCount: listItems.length,
                    position: currentIndex,
                    onTap: (position) async {
                      await carouselControllerEx.animateToPage(position);
                      currentIndex = position;
                    },
                    decorator: DotsDecorator(
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Fresh Recipes",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: Text(
                          "See All",
                          style: TextStyle(color: Colors.orange, fontSize: 18),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
