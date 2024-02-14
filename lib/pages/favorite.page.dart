import 'package:animated_list_item/animated_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/pages/notification.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/widgets/card.recipe.vertical.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/recipe.model.dart';
import '../widgets/header.bar.dart';
import 'filter.page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with SingleTickerProviderStateMixin {
  List<Recipe> searchedRecipes = [];
  List<Recipe> recipesList=[];
  final searchController = TextEditingController();
  String searchedRecipe = '';
  late AnimationController _animationController;


  @override
  void initState() {
    // TODO: implement initState
    searchedForRecipe('');
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _animationController.forward();

    super.initState();
  }

  void searchedForRecipe(String searchedRecipeLetter) async {

    searchedRecipes = recipesList
        .where((recipe) =>
            recipe.title!.toLowerCase().contains(searchedRecipeLetter))
        .toList();

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
            child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderBar(title: "Favorites", titleRight: ""),

                      SizedBox(
                        height: 20,
                      ),

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
                                  hintText: "searching".tr(),
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
                                child: InkWell(
                                    onTap: (){
                                      NavigationUtils.push(context: context, page: const FilterPage());
                                    },
                                    child: Icon(Icons.tune_sharp)),
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
                              return Container(
                                child: Center(child: Image.asset("assets/images/loading.gif"
                                  ,width: 200,height: 200,)),
                              );
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
                                      height:570,
                                     // MediaQuery.of(context).size.height,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: searchController
                                                  .text.isEmpty
                                              ? recipesList.length
                                              : searchedRecipes.length,
                                          itemBuilder: (context, index) {
                                            return AnimatedListItem(
                                              index: index,
                                              length: searchController
                                                  .text.isEmpty
                                                  ? recipesList.length
                                                  : searchedRecipes.length,
                                              aniController: _animationController,
                                              animationType: AnimationType.flipX,
                                              child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 10, bottom: 10),
                                                  child: CardRecipeVertical(
                                                      recipe: searchController
                                                              .text.isEmpty
                                                          ? recipesList[
                                                              index]
                                                          : searchedRecipes[
                                                              index])),
                                            );
                                          }));
                                }
                                else {
                                  return const Text('No Selected Recipes');
                                }
                              }
                            }
                          }),

                    ],
                  ),
                )

          ),
        ));
  }
}
