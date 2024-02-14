import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/provider/recipes.provider.dart';
import 'package:daily_recipe/widgets/animated.text.widget.dart';
import 'package:daily_recipe/widgets/direction.widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ingredients.dart';
import '../models/recipe.model.dart';
import '../widgets/favorite.icon.dart';

class RecipeViewPage extends StatefulWidget {
  RecipeViewPage({super.key, required this.recipe});
  Recipe recipe;

  @override
  State<RecipeViewPage> createState() => _RecipeViewPageState();
}

class _RecipeViewPageState extends State<RecipeViewPage> {
  @override
  void initState() {
    addRecipes();

    // TODO: implement initState
    super.initState();
  }

  Future<void> addRecipes() async {
    await Future.delayed(const Duration(milliseconds: 80));
    if (context.mounted) {
      Provider.of<RecipesProvider>(context, listen: false)
          .addViewedRecipesToUser(widget.recipe.docId!, context);
      Provider.of<RecipesProvider>(context, listen: false)
          .addFavoriteRecipesToUser(
              widget.recipe.docId!,
              widget.recipe.user_ids
                      ?.contains(FirebaseAuth.instance.currentUser?.uid) ??
                  false,
              context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.mealType!,
                    style: TextStyle(color: Colors.cyan[600], fontSize: 16),
                  ).tr(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.recipe.title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 20))
                            .tr(),
                        FavoriteIcon(recipe: widget.recipe),
                      ]),
                  Row(
                    children: [
                      Text(" ${widget.recipe.calories}",
                          style: const TextStyle(
                              color: Colors.deepOrange, fontSize: 14)),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text(" Calories",
                              style: TextStyle(
                                  color: Colors.deepOrange, fontSize: 14))
                          .tr(),
                    ],
                  ),
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
                              const Icon(Icons.access_time_outlined),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Text(" ${widget.recipe.prepTime!}",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    const Text(" mins",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14))
                                        .tr()
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.dinner_dining),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Text(" ${widget.recipe.serving}",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    const Text(" serving",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14))
                                        .tr()
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
                            offset: const Offset(20, 0),
                            child: FadeInImage(
                              placeholder:
                                  const AssetImage("assets/images/loading.gif"),
                              fadeInDuration: const Duration(seconds: 3),
                              fadeInCurve: Curves.easeIn,
                              width: 200,
                              height: 120,
                              image: NetworkImage(widget.recipe.image!),
                              fit: BoxFit.cover,
                            ),
                          ))
                    ],
                  ),
                  const Text("Ingredients",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20))
                      .tr(),
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
                                bool isExist = false;
                                for (var userIngredientsTitle
                                    in userIngredientsTitles) {
                                  if (recipeIngredient
                                      .contains(userIngredientsTitle.name!)) {
                                    isExist = true;
                                    break;
                                  } else {
                                    isExist = false;
                                  }
                                }

                                if (isExist) {
                                  return const Icon(
                                    Icons.add_circle_outline_sharp,
                                    color: Colors.deepOrange,
                                  );
                                } else {
                                  return const Icon(
                                    Icons.add_circle_outline_sharp,
                                    color: Colors.grey,
                                  );
                                }
                              }

                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...widget.recipe.ingredients
                                            ?.map((e) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      checkIngredientWidget(e),
                                                      const SizedBox(width: 10),
                                                      Flexible(
                                                        child:
                                                            AnimatedTextWidget(
                                                                text: e,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                size: 16),
                                                        /* Text(
                                                          e,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                          maxLines: 2,
                                                        ).tr(),*/
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
                    ),
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: DirectionWidget(directions: widget.recipe.directions)),
          ],
        ),
      ),
    )));
  }
}
