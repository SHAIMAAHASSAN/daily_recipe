import 'package:daily_recipe/widgets/card.recipe.dart';
import 'package:daily_recipe/widgets/card.recipe.vertical.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/recipes.provider.dart';
class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<RecipesProvider>(
            builder: (context, value, child)
            {
              print("==@@@@@@@@@@@@@@@@@@@@@@@@@2Recipes = ${value
                  .recipesList}====================");

              if (value.recipesList.isNotEmpty) {
                return  Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection:Axis.horizontal,
                            itemCount:value.recipesList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: CardRecipe(
                                    mealType: value.recipesList[index].mealType,
                                    title: value.recipesList[index].title,
                                    image: value.recipesList[index].image,
                                    calories: value.recipesList[index].calories,
                                    prepTime: value.recipesList[index].prepTime,
                                    serving: value.recipesList[index].serving),
                              );
                            }),
                      ),
                      /*SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Card(
                              child: SizedBox(height: 300,
                                child: CardRecipe(mealType:value.recipesList[0].mealType, title: value.recipesList[0].title,
                                    image: value.recipesList[0].image, calories: value.recipesList[0].calories,
                                    prepTime: value.recipesList[0].prepTime, serving:value.recipesList[0]. serving),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Card(
                              child: SizedBox(height: 300,
                                child: CardRecipe(mealType:value.recipesList[1].mealType, title: value.recipesList[1].title,
                                    image: value.recipesList[1].image, calories: value.recipesList[1].calories,
                                    prepTime: value.recipesList[1].prepTime, serving:value.recipesList[1]. serving),
                              ),
                            ),
                          ],
                        ),
                      ),*/
                      SizedBox(height: 10,),
                      Card(
                        child: SizedBox(
                          //height: 300,
                          child: CardRecipeVertical(mealType:value.recipesList[1].mealType, title: value.recipesList[1].title,
                              image: value.recipesList[1].image, calories: value.recipesList[1].calories,
                              prepTime: value.recipesList[1].prepTime, serving:value.recipesList[1]. serving),
                        ),
                      ),
                  ]
                );
              }
              return CircularProgressIndicator();
            }
        ),
      ),
    ));
  }
}