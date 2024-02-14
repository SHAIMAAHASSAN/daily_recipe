import 'package:animated_list_item/animated_list_item.dart';
import 'package:daily_recipe/provider/recipes.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/recipe.view.page.dart';
import '../utils/navigation.utils.dart';
import 'card.recipe.dart';

class FreshRecipesWidget extends StatefulWidget {
  const FreshRecipesWidget({super.key});

  @override
  State<FreshRecipesWidget> createState() => _FreshRecipesWidgetState();
}

class _FreshRecipesWidgetState extends State<FreshRecipesWidget>  with SingleTickerProviderStateMixin{
 late AnimationController _animationController;
 @override
 void initState() {
   super.initState();
   _animationController = AnimationController(
     duration: const Duration(milliseconds: 3000),
     vsync: this,
   );
   _animationController.forward();
 }


  @override
  Widget build(BuildContext context) {
    return Consumer<RecipesProvider>(builder: (context, value, child) {
      if (value.freshRecipesList.isNotEmpty) {

        return SizedBox(
          height:250,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: value.freshRecipesList.length,
              itemBuilder: (context, index) {
                return
                    AnimatedListItem(
                      index: index,
                      length: value.freshRecipesList.length,
                      aniController: _animationController,
                      animationType: AnimationType.zoom,

                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {
                        NavigationUtils.push(
                            context: context,
                            page:RecipeViewPage(recipe: value.freshRecipesList[index]),
                       );
                      },
                      child: CardRecipe(recipe: value.freshRecipesList[index]),

                    ),
                  ),
                );
              }),
        );
      }

      return Center(child: Image.asset("assets/images/loading.gif",width: 200,height: 200,));
    });
  }
}
