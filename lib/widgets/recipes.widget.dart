import 'package:daily_recipe/provider/recipes.provider.dart';
import 'package:daily_recipe/widgets/toast.message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/recipe.view.page.dart';
import '../provider/ads.provider.dart';
import '../utils/navigation.utils.dart';
import '../utils/toast.message.utils.dart';
import '../utils/toast.status.dart';
import 'card.recipe.dart';

class RecipesWidget extends StatefulWidget {
  const RecipesWidget({super.key, required this.scrollDirection});
  final Axis scrollDirection;
 // int currentIndex;

  @override
  State<RecipesWidget> createState() => _RecipesWidgetState();
}

class _RecipesWidgetState extends State<RecipesWidget> {
 late bool isRead;
   @override


  @override
  Widget build(BuildContext context) {
    return Consumer<RecipesProvider>(builder: (context, value, child) {
      //print(
         // "==@@@@@@@@@@@@@@@@@@@@@@@@@2Recipes = ${value.recipesList}====================");

      if (value.recipesList.isNotEmpty) {

       ToastMessageUtils.showToastMessage(
           context, ToastStatus.success, "Enjoy with our recipes.");


        return SizedBox(
          height: 300,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: value.recipesList.length,
              itemBuilder: (context, index) {
                isRead= Provider.of<RecipesProvider>(context, listen: false).
                recipesList[index].viewed_ids!.
                contains(FirebaseAuth.instance.currentUser?.uid);
                print("==================isRead=$isRead =============================");
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onDoubleTap: () {

                      isRead = !isRead;
                      value.addViewedRecipesToUser(
                          value.recipesList[index].docId!,
                          /*  isRead,*/context) ;
                      value.getViewedRecipes();


                      print(
                          "&&&&&&&&&&&&&&&&&&&&&&&&&&&GestureDetector&&&&&&&&&&&&&&&&&&&&");
                      NavigationUtils.push(
                          context: context,
                          page: RecipeViewPage(
                            mealType: value.recipesList[index].mealType,
                            title: value.recipesList[index].title,
                            image: value.recipesList[index].image,
                            calories: value.recipesList[index].calories,
                            prepTime: value.recipesList[index].prepTime,
                            serving: value.recipesList[index].serving,
                            ingredients: value.recipesList[index].ingredients,
                            directions: value.recipesList[index].directions,
                            currentIndex: index,
                          ));

                    },
                    child: CardRecipe(
                        mealType: value.recipesList[index].mealType,
                        title: value.recipesList[index].title,
                        image: value.recipesList[index].image,
                        calories: value.recipesList[index].calories,
                        prepTime: value.recipesList[index].prepTime,
                        serving: value.recipesList[index].serving,
                         currentIndex: index,
                         favorite: value.recipesList[index].favorite!,),
                  ),
                );
              }),
        );
      }

      return Container(
        child: Image.asset("assets/images/loading.gif"),
      );
    });
  }
}
