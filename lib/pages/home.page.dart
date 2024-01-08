import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/cubit/ads_cubit.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/pages/notification.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/widgets/ads.Carousal.dart';
import 'package:daily_recipe/widgets/card.recipe.dart';
import 'package:daily_recipe/widgets/card.recipe.vertical.dart';
import 'package:daily_recipe/widgets/header.bar.dart';
import 'package:daily_recipe/widgets/page.view.dart';
import 'package:daily_recipe/widgets/search.bar.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ad.model.dart';
import '../services/ads.services.dart';
import '../services/preference.services.dart';
import '../utils/navigation.utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>   with SingleTickerProviderStateMixin{

  late final TabController _tabController;
  // int currentIndex = 0;
  // var listItems =[1,2,3,4,5];
  var listItems = [
    ImagesPath.pic2,
    ImagesPath.pic3,
    ImagesPath.pic4,
    ImagesPath.cinnamon,
    ImagesPath.salmon,
    ImagesPath.frenchToast,
  ];

  // CarouselController carouselControllerEx = CarouselController();
  List<Recipe> recipeList = [];
  void getRecipe() async {
    var recipeData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(recipeData)["recipes"]);

    recipeList = dataDecoded.map((e) => Recipe.fromJson(e)).toList();

    print("***************************");
    print(recipeList[0].title);
    setState(() {});
  }

  List<Ad> adsList = [];

  void getAds() async {
    var adsData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);

    adsList = dataDecoded.map((e) => Ad.fromJson(e)).toList();
    setState(() {});
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
    getRecipe();

    // getAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     //   body: NestedScrollView(
     // headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
     //   return <Widget>[
          /*SliverAppBar(
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
              bottom:TabBar(
                controller: _tabController, // Assign a TabController
                tabs: [
                  // Your Tab widgets
                ],
              ),
              ),*/
      //  ];
   //   },

      /* appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SideMenuPage(),
                    ));
              },
              icon: const Icon(Icons.sort)),
          actions: [
            *//* IconButton(
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
                icon: Icon(Icons.logout_rounded)),*//*

            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationPage(),
                      ));
                },
                icon: const Icon(Icons.notifications)),
          ]),*/
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " Good Morning, "
                "${GetIt.I.get<SharedPreferences>().getString("name")}",
                //"${PreferencService.prefs?.getString("username")}",
                style: const TextStyle(color: Colors.grey),
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
              ),
              const SizedBox(
                height: 10,
              ),
             SearchBarEX(hintText: "Search for recipes"),

              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  //adsList.isEmpty
                  // ? const CircularProgressIndicator()
                  //  :
                  Container(
                      child: AdsCarousal()
                      /*CarouselSlider(
                            carouselController: carouselControllerEx,
                            options: CarouselOptions(
                              height: 200.0,
                            //  animateToClosest: true,
                              viewportFraction: .75,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              enlargeFactor: .3,
                              enlargeStrategy:
                                  CenterPageEnlargeStrategy.height,
                              onPageChanged: (index, _) {
                                currentIndex = index;
                                print("==========$currentIndex==========");
                                setState(() {});
                              },
                            ),
                            items: adsList.map(
                              (ad) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white70,),
                                  //  image: DecorationImage(image:  NetworkImage(ad.image!),  fit: BoxFit.fitWidth,
                                  //  )),

                                  child:
                                      //  Text("${i}")
                                       Image(
                                     image: NetworkImage(ad.image!),
                                     fit: BoxFit.fitWidth,
                                   )
                                );
                              },
                            ).toList(),
                          ),*/
                      ),
                  /*Positioned(
                      left: 20,
                      top: 100,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          size: 40,
                          color: Colors.brown,
                        ),
                        onPressed: () async {
                          carouselControllerEx.previousPage();
                          //if (currentIndex > 0) {
                          // await carouselControllerEx
                          //   .animateToPage(currentIndex - 1);
                          // } else {
                          // await carouselControllerEx
                          //  .animateToPage(listItems.length-1 );
                          // }
                        },
                      )),
                  Positioned(
                      right: 20,
                      top: 100,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_outlined,
                          size: 40,
                          color: Colors.brown,
                        ),
                        onPressed: () async {
                          carouselControllerEx.nextPage();
                          //  if (currentIndex < listItems.length - 1) {
                          // await carouselControllerEx
                          //    .animateToPage(currentIndex + 1);
                          //  } else {
                          //  await carouselControllerEx.animateToPage(0);
                          // }
                        },
                      ))*/
                ],
              ),
              //const SizedBox(
              // height: 10,
              //),
              /*Align(
                alignment: Alignment.center,
                child: DotsIndicator(
                  dotsCount: adsList.length,
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
              ),*/

              const SizedBox(
                height: 20,
              ),
              HeaderBar(
                  title: "Today's Fresh Recipes", titleRight: "See All"),
              const SizedBox(
                height: 20,
              ),

              //const SizedBox(
              //  height: 20,
              //  ),

              recipeList.isEmpty
                  ? const CircularProgressIndicator()
                  :

                  Container(
                      height: 300,
                      // color: Colors.cyan,
                      child: ListView.builder(
                          //shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: recipeList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: CardRecipe(
                                  mealType: recipeList[index].mealType,
                                  title: recipeList[index].title,
                                  image: recipeList[index].image,
                                  calories: recipeList[index].calories,
                                  prepTime: recipeList[index].prepTime,
                                  serving: recipeList[index].serving),
                            );
                          }),
                    ),
              SizedBox(
                height: 20,
              ),
              HeaderBar(title: "Recommended", titleRight: "See All"),
              SizedBox(
                height: 20,
              ),
              CardRecipeVertical(
                  mealType: recipeList[2].mealType,
                  title: recipeList[2].title,
                  image: recipeList[2].image,
                  calories: recipeList[2].calories,
                  prepTime: recipeList[2].prepTime,
                  serving: recipeList[2].serving),
              SizedBox(
                height: 15,
              ),
              CardRecipeVertical(
                  mealType: recipeList[1].mealType,
                  title: recipeList[1].title,
                  image: recipeList[1].image,
                  calories: recipeList[1].calories,
                  prepTime: recipeList[1].prepTime,
                  serving: recipeList[1].serving),
            ],
          ),
        ),
      ),
   // )
    );
  }
}
