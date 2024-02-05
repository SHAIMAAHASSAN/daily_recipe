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

class FreshRecipesWidget extends StatefulWidget {
  const FreshRecipesWidget({super.key,/*required this.currentIndex*/});

  //int currentIndex;

  @override
  State<FreshRecipesWidget> createState() => _FreshRecipesWidgetState();
}

class _FreshRecipesWidgetState extends State<FreshRecipesWidget> {
 late bool isRead;
   @override


  @override
  Widget build(BuildContext context) {
    return Consumer<RecipesProvider>(builder: (context, value, child) {
      //print(
         // "==@@@@@@@@@@@@@@@@@@@@@@@@@2Recipes = ${value.recipesList}====================");

      if (value.freshrecipesList.isNotEmpty) {

      // ToastMessageUtils.showToastMessage(
        //   context, ToastStatus.success, "Enjoy with our recipes.");


        return SizedBox(
          height:250,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: value.freshrecipesList.length,
              itemBuilder: (context, index) {
               /* isRead= Provider.of<RecipesProvider>(context, listen: false).
               freshrecipesList[index].viewed_ids!.
                contains(FirebaseAuth.instance.currentUser?.uid);
                print("==================isRead=$isRead =============================");*/
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onDoubleTap: () {

                     /* isRead = !isRead;
                      value.addViewedRecipesToUser(
                          value.freshrecipesList[index].docId!,
                          *//*  isRead,*//*context) ;
                      value.getViewedRecipes();


                      print(
                          "&&&&&&&&&&&&&&&&&&&&&&&&&&&GestureDetector&&&&&&&&&&&&&&&&&&&&");*/
                      NavigationUtils.push(
                          context: context,
                          page:RecipeViewPage(recipe: value.freshrecipesList[index]),

                        /*RecipeViewPage(
                            mealType: value.freshrecipesList[index].mealType,
                            title: value.freshrecipesList[index].title,
                            image: value.freshrecipesList[index].image,
                            calories: value.freshrecipesList[index].calories,
                            prepTime: value.freshrecipesList[index].prepTime,
                            serving: value.freshrecipesList[index].serving,
                            ingredients: value.freshrecipesList[index].ingredients,
                            directions: value.freshrecipesList[index].directions,
                            currentIndex: index,
                          )*/
                      );
                    },
                    child: CardRecipe(recipe: value.freshrecipesList[index]),

                    /*CardRecipe(
                        mealType: value.freshrecipesList[index].mealType,
                        title: value.freshrecipesList[index].title,
                        image: value.freshrecipesList[index].image,
                        calories: value.freshrecipesList[index].calories,
                        prepTime: value.freshrecipesList[index].prepTime,
                        serving: value.freshrecipesList[index].serving,
                         currentIndex: index,
                         //favorite: value.recipesList[index].favorite!
                    ),*/
                  ),
                );
              }),
        );
      }

      return Container(
        child: Center(child: Image.asset("assets/images/loading.gif",width: 200,height: 200,)),
      );
    });
  }
}
