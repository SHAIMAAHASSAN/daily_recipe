import 'package:animated_list_item/animated_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:daily_recipe/pages/filter.page.dart';
import 'package:daily_recipe/pages/notification.page.dart';
import 'package:daily_recipe/pages/recipe.view.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/widgets/header.bar.dart';
import 'package:easy_localization/easy_localization.dart';
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

class _RecentlyViewedPageState extends State<RecentlyViewedPage>
    with SingleTickerProviderStateMixin {
  List<Recipe> recipeList = [];
  List<Recipe> searchedRecipes = [];

  final searchController = TextEditingController();
  String searchedRecipe = '';

  void searchedForRecipe(String searchedRecipeLetter) async {
    searchedRecipes = recipeList
        .where((recipe) =>
            recipe.title!.toLowerCase().contains(searchedRecipeLetter))
        .toList();

    setState(() {});
  }

  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    searchedForRecipe('');
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationPage(),
                      ));
                },
                icon: const Icon(Icons.notifications)),
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 HeaderBar(title: "Recently Viewed".tr(), titleRight: ""),
                const SizedBox(
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
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.shade600,
                              size: 20,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.all(10),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                          ),
                        ),
                      ),
                      const SizedBox(
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
                              onTap: () => NavigationUtils.push(
                                  context: context, page: const FilterPage()),
                              child: const Icon(Icons.tune_sharp)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
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
                        return Container(
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
                                      return AnimatedListItem(
                                        index: index,
                                        length: searchController.text.isEmpty
                                            ? recipeList.length
                                            : searchedRecipes.length,
                                        aniController: _animationController,
                                        animationType: AnimationType.zoom,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Stack(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    NavigationUtils.push(
                                                        context: context,
                                                        page: RecipeViewPage(
                                                            recipe: recipeList[
                                                                index]));
                                                  },
                                                  child: CardRecipeVertical(
                                                      recipe: searchController
                                                              .text.isEmpty
                                                          ? recipeList[index]
                                                          : searchedRecipes[
                                                              index]),
                                                ),
                                                Positioned(
                                                    top: 8,
                                                    right: 10,
                                                    child: GestureDetector(
                                                        onTap: () => Provider
                                                                .of<RecipesProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            .clearViewedRecipes(
                                                                recipeList[
                                                                        index]
                                                                    .docId!),
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.grey,
                                                              size: 25,
                                                            ))))
                                              ],
                                            )),
                                      );
                                    }));
                          } else {
                            return const Text('No Selected Recipes');
                          }
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
