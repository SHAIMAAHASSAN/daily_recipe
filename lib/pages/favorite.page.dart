import 'package:daily_recipe/pages/notification.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/widgets/card.recipe.vertical.dart';
import 'package:daily_recipe/widgets/search.bar.dart';
import 'package:flutter/material.dart';

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
  List<Recipe> searchedRecipes =[];
  List<Recipe> recipes =[];
  final searchController =TextEditingController();
   String searchedRecipe='';
  bool _isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    searchedForRecipe('');
    FetchData.fetchRecipesFromJson();
    print("============================fetches recipes=${ FetchData.fetchRecipesFromJson()}========================");
    super.initState();
  }

  void searchedForRecipe (String searchedRecipe) async{
   /* FetchData.fetchRecipesFromJson().then((value) {
      value =recipes;
    });*/
    try {
      List<Recipe> recipelist = await  (FetchData.fetchRecipesFromJson());
      recipes.addAll(recipelist);
      print("===================recipes=${recipes.length}==================");
    } catch (error) {
      print("===============$error==============");
    }
    searchedRecipes= recipes.where((recipe) => recipe.title!.toLowerCase().startsWith(searchedRecipe)).toList();

    print("=================searched=$searchedRecipes");
    //setState(() {
   // });
    /*recipes = searchedRecipe.isEmpty
        ? recipes // If search query is empty, show all recipes
        : List<Recipe>.from(recipes).where((recipe) {
      return recipe.title!.toLowerCase().startsWith(searchedRecipe);
    }).toList(); // Otherwise, show filtered recipes*/

    setState(() {
    });

  }



  @override
  Widget build(BuildContext context) {
    print("Recipes=${recipes.length}==========");
    return Scaffold(
      /*appBar: AppBar(
          leading: IconButton(
              onPressed: () {
               NavigationUtils.push(context: context, page: SideMenuPage()),

              },
              icon: Icon(Icons.sort)),
          actions: [
            IconButton(
                onPressed: () {
                 NavigationUtils.push(context: context, page: NotificationPage()),
                },
                icon: Icon(Icons.notifications)),
          ]),*/
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                HeaderBar(title:  "Favorites", titleRight:  ""),


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
                    height: 570,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                      searchController.text.isEmpty?
                      recipes.length
                      :searchedRecipes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            child:
                            //

                            CardRecipeVertical(
                                mealType: searchController.text.isEmpty? recipes[index].mealType : searchedRecipes[index].mealType,
                                title: searchController.text.isEmpty?recipes[index].title: searchedRecipes[index].title,
                                image: searchController.text.isEmpty?recipes[index].image : searchedRecipes[index].image,
                                calories: searchController.text.isEmpty?recipes[index].calories : searchedRecipes[index].calories,
                                prepTime:searchController.text.isEmpty? recipes[index].prepTime : searchedRecipes[index].prepTime,
                                serving: searchController.text.isEmpty?recipes[index].serving : searchedRecipes[index].serving)

                        );

                      }),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
