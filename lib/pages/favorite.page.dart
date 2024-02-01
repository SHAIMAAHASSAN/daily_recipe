import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/pages/notification.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/provider/recipes.provider.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/widgets/card.recipe.vertical.dart';
import 'package:daily_recipe/widgets/search.bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recipe.model.dart';
import '../services/ads.services.dart';
import '../widgets/card.recipe.dart';
import '../widgets/header.bar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Recipe> searchedRecipes = [];
  List<Recipe> recipesList=[];
 // List<Recipe> favoriteRecipeList = [];
  final searchController = TextEditingController();
  String searchedRecipe = '';
  bool _isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    searchedForRecipe('');

    super.initState();
  }

  void searchedForRecipe(String searchedRecipeLetter) async {
   /* favoriteRecipeList = Provider.of<RecipesProvider>(context, listen: false)
        .favoriteRecipesList;*/

    searchedRecipes = recipesList
        .where((recipe) =>
            recipe.title!.toLowerCase().contains(searchedRecipeLetter))
        .toList();

    print("=================searched=$searchedRecipes");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  NavigationUtils.push(context: context, page: SideMenuPage());
                },
                icon: Icon(Icons.sort)),
            actions: [
              IconButton(
                  onPressed: () {
                    NavigationUtils.push(
                        context: context, page: NotificationPage());
                  },
                  icon: Icon(Icons.notifications)),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SafeArea(
            child: /*Consumer<RecipesProvider>(builder: (context, value, child) {
              *//* print(
              "==@@@@@@@@@@@@@@@@@@@@@@@@@2Recipes = ${value.recipesList}====================");*//*

              if (value.favoriteRecipesList.isNotEmpty) {
                return*/ SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderBar(title: "Favorites", titleRight: ""),

                      SizedBox(
                        height: 20,
                      ),

                      //SearchBarEX(hintText: "Search Using Keywords",),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextField(
                                controller: searchController,
                                onChanged: searchedForRecipe,
                                decoration: InputDecoration(
                                  hintText: "searching",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade600),
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
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade100)),
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
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('recipes')
                              .where("user_ids",
                                  arrayContains:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (snapshots.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              if (snapshots.hasError) {
                                return const Text('ERROR WHEN GET DATA');
                              } else {
                                if (snapshots.hasData) {
                                   recipesList = snapshots
                                          .data?.docs
                                          .map((e) =>
                                              Recipe.fromJson(e.data(), e.id))
                                          .toList() ??
                                      [];
                                  return SizedBox(
                                      height: 570,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: searchController
                                                  .text.isEmpty
                                              ? recipesList.length
                                              : searchedRecipes.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: CardRecipeVertical(
                                                    recipe: searchController
                                                            .text.isEmpty
                                                        ? recipesList[
                                                            index]
                                                        : searchedRecipes[
                                                            index]));
                                          }));


                                } else {
                                  return const Text('No Selected Recipes');
                                }
                              }
                            }
                          }),

                      /*SizedBox(
                    height: 570,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchController.text.isEmpty
                            ? value.favoriteRecipesList.length
                            : searchedRecipes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child:CardRecipeVertical(recipe: searchController.text.isEmpty?value.favoriteRecipesList[index
                              ]:searchedRecipes[index])


                                  //

                                  */ /*CardRecipeVertical(
                                      mealType: searchController.text.isEmpty
                                          ? value.favoriteRecipesList[index].mealType
                                          : searchedRecipes[index].mealType,
                                      title: searchController.text.isEmpty
                                          ? value.favoriteRecipesList[index].title
                                          : searchedRecipes[index].title,
                                      image: searchController.text.isEmpty
                                          ? value.favoriteRecipesList[index].image
                                          : searchedRecipes[index].image,
                                      calories: searchController.text.isEmpty
                                          ? value.favoriteRecipesList[index].calories
                                          : searchedRecipes[index].calories,
                                      prepTime: searchController.text.isEmpty
                                          ? value.favoriteRecipesList[index].prepTime
                                          : searchedRecipes[index].prepTime,
                                      currentIndex: index,
                                      serving: searchController.text.isEmpty
                                          ? value.favoriteRecipesList[index].serving
                                          : searchedRecipes[index].serving),*/ /*
                                                      );
                        }),
                  ),*/
                    ],
                  ),
                )
            /*  } else if (value.favoriteRecipesList.isEmpty) {
                return Text(" No selected Recipes");
              } else
                return Container(
                  child: Image.asset("assets/images/loading.gif"),
                );*/
           // }
           // ),
          ),
        ));
  }
}
