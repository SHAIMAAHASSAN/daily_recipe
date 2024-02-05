import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/provider/ads.provider.dart';
import 'package:daily_recipe/provider/recipes.provider.dart';
import 'package:daily_recipe/widgets/bottom.sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ingredients.dart';
import '../models/recipe.model.dart';
import '../widgets/favorite.icon.dart';

class RecipeViewPage extends StatefulWidget {
  RecipeViewPage({
    super.key,
    required this.recipe
   /* required this.mealType,
    required this.title,
    required this.image,
    required this.calories,
    required this.prepTime,
    required this.serving,
    required this.ingredients,
    required this.directions,*/
    /* required this.currentIndex*/
  });
  Recipe recipe;

  @override
  State<RecipeViewPage> createState() => _RecipeViewPageState();
}

class _RecipeViewPageState extends State<RecipeViewPage> {
 /* String? mealType;
  String? title;
  //String? description;
  String? image;
  // int? rating;
  int? prepTime;
  int? serving;
  int? calories;
  List<dynamic>? ingredients;
  Map<String, dynamic>? directions;
  int currentIndex = 0;*/

 @override
  void initState() {
   addRecipes();

    // TODO: implement initState
    super.initState();
  }
   Future<void> addRecipes() async {
     await Future.delayed(const Duration(milliseconds: 80));
     Provider.of<RecipesProvider>(context, listen: false).addViewedRecipesToUser(widget.recipe.docId!, context);
     Provider.of<RecipesProvider>(context, listen: false).addFavoriteRecipesToUser(widget.recipe.docId!,
         widget.recipe.user_ids
             ?.contains(FirebaseAuth.instance.currentUser?.uid) ??
             false,context);

}

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
      */ /*  isRead,*/ /*context) ;
    Provider.of<RecipesProvider>(context, listen: false).getViewedRecipes();*/
    // final ScrollController scrollController = ScrollController();
    print("================${widget.recipe.mealType}===========================");
    print(
        "000000000000000000000000000000000000${widget.recipe}.directions 0000000000000000000000000000000");
    print("77777777777777777777777777${widget.recipe}.ingredients 777777777777777777777777777");
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
                   widget.recipe. mealType!,
                    style: TextStyle(color: Colors.cyan[600], fontSize: 16),
                  ).tr(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text( widget.recipe.title!,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20)).tr(),
                         FavoriteIcon(recipe: widget.recipe),

                      ]),
                  Row(
                    children: [
                      Text(" ${ widget.recipe.calories}",
                          style: TextStyle(
                              color: Colors.deepOrange, fontSize: 14)),
                      SizedBox(width: 3,),
                      Text(" Calories",
                          style: TextStyle(color: Colors.deepOrange, fontSize: 14)).tr(),
                    ],
                  ),
                 /* Text(" ${ widget.recipe.calories} Calories",
                      style: TextStyle(color: Colors.deepOrange, fontSize: 14)).tr(),*/
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
                                child: Row(
                                  children: [
                                    Text(" ${ widget.recipe.prepTime!}",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                    SizedBox(width: 3,),
                                    Text(" mins",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14)).tr()
                                  ],
                                ),
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
                                child: Row(
                                  children: [
                                    Text(" ${ widget.recipe.serving}",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                    SizedBox(width: 3,),
                                    Text(" serving",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14)).tr()
                                  ],
                                ),
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
                              image: NetworkImage( widget.recipe.image!),
                              fit: BoxFit.cover,
                            ),
                          ) // Use 'favorite_border' initially)

                          )
                    ],
                  ),
                  Text("Ingredients",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20)).tr(),
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('userIngredients')
                              .where('usersIng_ids',
                                  arrayContains:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .get(),
                          builder: (context, snapShot) {
                            if (snapShot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              var userIngredients = List<Ingredient>.from(
                                  snapShot.data!.docs
                                      .map((e) =>
                                          Ingredient.fromJson(e.data(), e.id))
                                      .toList());

                              var userIngredientsTitles =
                                  userIngredients.map((e) => e).toList();

                              Widget checkIngredientWidget(
                                  String recipeIngredient) {
                                bool isExsist = false;
                                for (var userIngredientsTitle
                                    in userIngredientsTitles) {
                                  if (recipeIngredient
                                      .contains(userIngredientsTitle.name!)) {
                                    isExsist = true;
                                    break;
                                  } else {
                                    isExsist = false;
                                  }
                                }

                                if (isExsist) {
                                  return Icon( Icons.add_circle_outline_sharp,
                                    color: Colors.deepOrange,);
                                } else {
                                  return Icon( Icons.add_circle_outline_sharp,
                                    color: Colors.grey,);
                                }
                              }

                              return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    ...widget.recipe.ingredients
                                            ?.map((e) => Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                    children: [
                                                      checkIngredientWidget(e),
                                                      SizedBox(
                                                          width:
                                                          10),
                                                      Flexible(
                                                        child: Text(
                                                          e,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                          maxLines: 2,
                                                        ).tr(),
                                                      ),

                                                    ],
                                                  ),
                                            ))
                                            .toList() ??
                                        [],
                                  ] // ...ingredients!.map((e)

                                  );
                            }
                          }),

                      /*Column(
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
                      ),*/
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
                    widget.recipe.directions /*,scrollController: scrollController,*/)),
          ],
        ),
      ),
    )));
  }
}
