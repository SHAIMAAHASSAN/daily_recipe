import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:daily_recipe/pages/notification.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/widgets/header.bar.dart';
import 'package:daily_recipe/widgets/fresh.recipes.widget.dart';
import 'package:daily_recipe/widgets/search.bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/recipes.provider.dart';
import '../widgets/card.recipe.vertical.dart';

class RecentlyViewedPage extends StatefulWidget {
  const RecentlyViewedPage({super.key});

  @override
  State<RecentlyViewedPage> createState() => _RecentlyViewedPageState();
}

class _RecentlyViewedPageState extends State<RecentlyViewedPage> {
  List<Recipe> recipeList = [];
  List<Recipe> searchedRecipes = [];

  final searchController = TextEditingController();
  String searchedRecipe = '';

  void searchedForRecipe(String searchedRecipeLetter) async {
    /* favoriteRecipeList = Provider.of<RecipesProvider>(context, listen: false)
        .favoriteRecipesList;*/

    searchedRecipes = recipeList
        .where((recipe) =>
            recipe.title!.toLowerCase().startsWith(searchedRecipeLetter))
        .toList();

    print("=================searched=$searchedRecipes");

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    searchedForRecipe('');

    super.initState();
  }

  /*bool get isUserInList => (widget.recipe.viewed_ids
      ?.contains(FirebaseAuth.instance.currentUser?.uid) ??
      false);*/

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderBar(title: "Recently Viewed", titleRight: ""),
                SizedBox(
                  height: 20,
                ),
                // SearchBarEX(hintText: "Search Using Keywords"),
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
                  height: 10,
                ),

                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('recipes')
                        .where("viewed_ids",
                            arrayContains:
                                FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return  Container(
                          child: Image.asset("assets/images/loading.gif"),
                        );
                      } else {
                        if (snapshots.hasError) {
                          return const Text('ERROR WHEN GET DATA');
                        } else {
                          if (snapshots.hasData) {
                            recipeList = snapshots.data?.docs
                                    .map((e) => Recipe.fromJson(e.data(), e.id))
                                    .toList() ??
                                [];
                            return SizedBox(
                                height: 570,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchController.text.isEmpty
                                        ? recipeList.length
                                        : searchedRecipes.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Stack(
                                            children: [
                                              CardRecipeVertical(
                                                  recipe: searchController
                                                          .text.isEmpty
                                                      ? recipeList[index]
                                                      : searchedRecipes[index]),
                                              Positioned(
                                                 top: 8,
                                                  right: 18,
                                                  child: GestureDetector(
                                                      onTap: () => Provider.of<
                                                                  RecipesProvider>(
                                                              context,
                                                              listen: false)
                                                          .clearViewedRecipes(
                                                              recipeList[index]
                                                                  .docId!),
                                                      child: Container(
                                                          color: Colors.grey[200],
                                                          child: Icon(Icons.clear,color: Colors.grey,size: 25,))))
                                            ],
                                          ));
                                    }));
                          } else {
                            return const Text('No Selected Recipes');
                          }
                        }
                      }
                    }),

                /* Consumer<RecipesProvider>(builder: (context, value, child) {
                  */ /* print(
              "==@@@@@@@@@@@@@@@@@@@@@@@@@2Recipes = ${value.recipesList}====================");*/ /*

                  if (value.viewedRecipesList.isNotEmpty) {
                    return SizedBox(
                      height: 570,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.viewedRecipesList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: CardRecipeVertical(recipe: recipe)

                              */ /*CardRecipeVertical(
                                  mealType:
                                      value.viewedRecipesList[index].mealType,
                                  title: value.viewedRecipesList[index].title,
                                  image: value.viewedRecipesList[index].image,
                                  calories:
                                      value.viewedRecipesList[index].calories,
                                  prepTime:
                                      value.viewedRecipesList[index].prepTime,
                                  currentIndex: index,
                                  serving:
                                      value.viewedRecipesList[index].serving,
                                )*/ /*
                            );
                          }),
                    );*/
                /* } else if (value.viewedRecipesList.isEmpty) {
                    return const Text("No selected Recipes");
                  } else
                    return Container(
                      child: Image.asset("assets/images/loading.gif"),
                    );
                }),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
