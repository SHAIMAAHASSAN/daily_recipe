import 'package:daily_recipe/widgets/card.recipe.vertical.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/recipe.view.page.dart';
import '../provider/recipes.provider.dart';
import '../utils/navigation.utils.dart';
class RecommendedRecipesWidget extends StatefulWidget {
  const RecommendedRecipesWidget({super.key});

  @override
  State<RecommendedRecipesWidget> createState() => _RecommendedRecipesWidgetState();
}

class _RecommendedRecipesWidgetState extends State<RecommendedRecipesWidget> {
  @override
  Widget build(BuildContext context) {
    return  Consumer<RecipesProvider>(builder: (context, value, child) {
      //print(
      // "==@@@@@@@@@@@@@@@@@@@@@@@@@2Recipes = ${value.recipesList}====================");

      if (value.recommendrecipesList.isNotEmpty) {

        // ToastMessageUtils.showToastMessage(
        //   context, ToastStatus.success, "Enjoy with our recipes.");


        return SizedBox(

           height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              shrinkWrap: true,
             // scrollDirection: Axis.vertical,
              itemCount: value.recommendrecipesList.length,
              itemBuilder: (context, index) {
                //isRead= Provider.of<RecipesProvider>(context, listen: false).
              //  freshrecipesList[index].viewed_ids!.
               // contains(FirebaseAuth.instance.currentUser?.uid);
               // print("==================isRead=$isRead =============================");
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10,right: 10,left: 10),
                  child: GestureDetector(
                    onDoubleTap: () {

                     /* isRead = !isRead;
                      value.addViewedRecipesToUser(
                          value.freshrecipesList[index].docId!,
                          *//*  isRead,*//*context) ;
                      value.getViewedRecipes();
          */

                      print(
                          "&&&&&&&&&&&&&&&&&&&&&&&&&&&GestureDetector&&&&&&&&&&&&&&&&&&&&");
                      NavigationUtils.push(
                          context: context,
                          page:RecipeViewPage(recipe: value.recommendrecipesList[index])
                        
                        /* RecipeViewPage(
                            mealType: value.recommendrecipesList[index].mealType,
                            title: value.recommendrecipesList[index].title,
                            image: value.recommendrecipesList[index].image,
                            calories: value.recommendrecipesList[index].calories,
                            prepTime: value.recommendrecipesList[index].prepTime,
                            serving: value.recommendrecipesList[index].serving,
                            ingredients: value.recommendrecipesList[index].ingredients,
                            directions: value.recommendrecipesList[index].directions,
                            //currentIndex: index,
                          )*/
                      );
                    },
                    child:CardRecipeVertical(recipe: value.recommendrecipesList[index])
                    
                    /*CardRecipeVertical(
                      mealType: value.recommendrecipesList[index].mealType,
                      title: value.recommendrecipesList[index].title,
                      image: value.recommendrecipesList[index].image,
                      calories: value.recommendrecipesList[index].calories,
                      prepTime: value.recommendrecipesList[index].prepTime,
                      serving: value.recommendrecipesList[index].serving,
                      *//* currentIndex: index,
                         favorite: value.recipesList[index].favorite!*//*),*/
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
