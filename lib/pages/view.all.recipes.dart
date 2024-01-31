import 'package:daily_recipe/pages/recipe.view.page.dart';
import 'package:daily_recipe/provider/recipes.provider.dart';
import 'package:daily_recipe/widgets/card.recipe.dart';
import 'package:daily_recipe/widgets/fresh.recipes.widget.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/navigation.utils.dart';
class ViewAllRecipes extends StatefulWidget {
  const ViewAllRecipes({super.key});

  @override
  State<ViewAllRecipes> createState() => _ViewAllRecipesState();
}

class _ViewAllRecipesState extends State<ViewAllRecipes> {
  @override
  void initState() {
    Provider.of<RecipesProvider>(context, listen: false).getRecipes(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<RecipesProvider>(
              builder: (context, value, _) =>
              value.recipesList == null
                  ? const CircularProgressIndicator()
                  : (value.recipesList?.isEmpty ?? false)
                  ? const Text('No Data Found')
                  : FlexibleGridView(
                axisCount: GridLayoutEnum.twoElementsInRow,
                crossAxisSpacing:10,
                mainAxisSpacing: 10,
                children: value.recipesList!
                    .map((e) => GestureDetector(onTap: ()=>NavigationUtils.push(context: context, page:
               RecipeViewPage(recipe: e)),
                      child: CardRecipe(recipe: e),
                    ))
                    .toList(),
              )),
        ));
  }
}
