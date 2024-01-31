import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/recipe.view.page.dart';
import '../provider/recipes.provider.dart';
import '../utils/navigation.utils.dart';
import 'card.recipe.vertical.dart';
class FiltterRecipes extends StatefulWidget {
   FiltterRecipes({super.key,required this .valueselected});
    Map<String,dynamic> valueselected ;
  @override
  State<FiltterRecipes> createState() => _FiltterRecipesState();
}

class _FiltterRecipesState extends State<FiltterRecipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body: Consumer<RecipesProvider>(builder: (context, value, child) {
        print(
         "==@@@@@@@@@@@@@@@@@@@@@@@@@2filtter = ${value.filtterRecipesList}====================");

        value.getFilteredResult(widget.valueselected);

        if (value.filtterRecipesList.isNotEmpty) {

          // ToastMessageUtils.showToastMessage(
          //   context, ToastStatus.success, "Enjoy with our recipes.");


          return SizedBox(

            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                shrinkWrap: true,

                itemCount: value.filtterRecipesList.length,
                itemBuilder: (context, index) {

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10,right: 10,left: 10),
                    child: GestureDetector(
                        onDoubleTap: () {


                          print(
                              "&&&&&&&&&&&&&&&&&&&&&&&&&&&GestureDetector&&&&&&&&&&&&&&&&&&&&");
                          NavigationUtils.push(
                              context: context,
                              page:RecipeViewPage(recipe: value.filtterRecipesList[index])


                          );
                        },
                        child:CardRecipeVertical(recipe: value.filtterRecipesList[index])


                    ),
                  );
                }),
          );
        }

        return Container(
          child: Image.asset("assets/images/loading.gif"),
        );
      })
      ,);
  }
}
