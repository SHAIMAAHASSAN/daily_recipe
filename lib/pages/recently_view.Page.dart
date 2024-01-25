import 'package:daily_recipe/pages/notification.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/widgets/header.bar.dart';
import 'package:daily_recipe/widgets/recipes.widget.dart';
import 'package:daily_recipe/widgets/search.bar.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<RecipesProvider>(context, listen: false).getViewedRecipes();
    super.initState();
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
                HeaderBar(title: "Recently Viewed", titleRight: "Clear"),
                SizedBox(
                  height: 20,
                ),
                SearchBarEX(hintText: "Search Using Keywords"),
                Consumer<RecipesProvider>(builder: (context, value, child) {
                  /* print(
              "==@@@@@@@@@@@@@@@@@@@@@@@@@2Recipes = ${value.recipesList}====================");*/

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
                                child: CardRecipeVertical(
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
                                ));
                          }),
                    );
                  } else if (value.viewedRecipesList.isEmpty) {
                    return const Text("No selected Recipes");
                  } else
                    return Container(
                      child: Image.asset("assets/images/loading.gif"),
                    );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
