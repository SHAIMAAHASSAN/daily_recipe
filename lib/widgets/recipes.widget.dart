import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/home.view.model.dart';
import 'card.recipe.dart';
class RecipesWidget extends StatelessWidget {
  const RecipesWidget({super.key,required this.scrollDirection});
 final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
        builder: (context, value, child) {
          if(value.recipeList.isNotEmpty){
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: scrollDirection,
                itemCount:value.recipeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CardRecipe(
                        mealType: value.recipeList[index].mealType,
                        title: value.recipeList[index].title,
                        image: value.recipeList[index].image,
                        calories: value.recipeList[index].calories,
                        prepTime: value.recipeList[index].prepTime,
                        serving: value.recipeList[index].serving),
                  );
                });


          }

          return Container(
            child: CircularProgressIndicator(),
          );
    });
  }
}
