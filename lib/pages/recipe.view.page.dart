import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:daily_recipe/provider/ads.provider.dart';
import 'package:daily_recipe/provider/recipes.provider.dart';
import 'package:daily_recipe/widgets/bottom.sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/favorite.icon.dart';

class RecipeViewPage extends StatelessWidget {
  RecipeViewPage(
      {super.key,
      required this.mealType,
      required this.title,
      required this.image,
      required this.calories,
      required this.prepTime,
      required this.serving,
      required this.ingredients,
      required this.directions,
  required this.currentIndex});
  String? mealType;
  String? title;
  //String? description;
  String? image;
  // int? rating;
  int? prepTime;
  int? serving;
  int? calories;
  List<dynamic>? ingredients;
  Map<String, dynamic>? directions;
  int currentIndex;

  @override
  Widget build(BuildContext context) {
  /*  bool isRead;

    isRead= Provider.of<RecipesProvider>(context, listen: false).
    recipesList[currentIndex].viewed_ids!.
    contains(FirebaseAuth.instance.currentUser?.uid);
    print("==================isRead=$isRead %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    isRead = !isRead;
    Provider.of<RecipesProvider>(context, listen: false).addViewedRecipesToUser(
        Provider.of<RecipesProvider>(context, listen: false).recipesList[currentIndex].docId!,
      *//*  isRead,*//*context) ;
    Provider.of<RecipesProvider>(context, listen: false).getViewedRecipes();*/
    // final ScrollController scrollController = ScrollController();
    print("================$mealType===========================");
    print(
        "000000000000000000000000000000000000$directions 0000000000000000000000000000000");
    print("77777777777777777777777777$ingredients 777777777777777777777777777");
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      //controller:scrollController ,
      child: Container(
        // height: 200,
        color: Colors.grey[200],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mealType!,
                    style: TextStyle(color: Colors.cyan[600], fontSize: 16),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title!,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20)),
                        FavoriteIcon(currentIndex: currentIndex,),
                      ]),
                  Text(" ${calories} Calories",
                      style: TextStyle(color: Colors.deepOrange, fontSize: 14)),
                  AnimatedRatingBar(
                    //height: 35,
                    initialRating: 0,
                    animationColor: Colors.yellow,
                    strokeColor: Colors.grey,
                    activeFillColor: Colors.deepOrange,
                    onRatingUpdate: (double value) {
                      // setState(() {});
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.access_time_outlined),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(" ${prepTime!} mins",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.dinner_dining),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(" ${serving} serving",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                          // width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.deepOrange,
                          ),
                          child: Transform.translate(
                            offset: Offset(20, 0),
                            child: FadeInImage(
                              placeholder:
                                  AssetImage("assets/images/loading.gif"),
                              fadeInDuration: Duration(seconds: 3),
                              fadeInCurve: Curves.easeIn,
                              width: 200,
                              height: 120,
                              image: NetworkImage(image!),
                              fit: BoxFit.cover,
                            ),
                          ) // Use 'favorite_border' initially)

                          )
                    ],
                  ),
                  Text("Ingredients",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...ingredients!.map((e) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // Wrap the icon and text in a Row
                                children: [
                                  Icon(
                                    Icons.add_circle_outline_sharp,
                                    color: Colors.deepOrange,
                                    size: 12,
                                  ), // Add the icon here
                                  SizedBox(
                                      width:
                                          10), // Optional spacing between icon and text
                                  Flexible(
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList()
                        ],
                      ),
                    ),
                  ),

                  /*Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () => showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible:false,
                          context: context,
                          builder: (context) => BuildBottomSheet(),
                        ),
                        child: Text('Directions'),
                      ),
                    )*/
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: BuildBottomSheet(
                    directions:
                        directions /*,scrollController: scrollController,*/)),
          ],
        ),
      ),
    )));
  }
}
