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


      if (value.recommendRecipesList.isNotEmpty) {

        return SizedBox(
          height:  MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(

            scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: value.recommendRecipesList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10,right: 10,left: 10),
                  child: GestureDetector(
                    onTap: () {

                      NavigationUtils.push(
                          context: context,
                          page:RecipeViewPage(recipe: value.recommendRecipesList[index])

                      );
                    },
                    child:CardRecipeVertical(recipe: value.recommendRecipesList[index])

                  ),
                )
                ;
              }),
        );
      }

      return Container(
        child: Image.asset("assets/images/loading.gif"),
      );
    });
  }
}
