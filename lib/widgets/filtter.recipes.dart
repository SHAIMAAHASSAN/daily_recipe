import 'package:daily_recipe/widgets/header.bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/notification.page.dart';
import '../pages/recipe.view.page.dart';
import '../pages/side.menu.page.dart';
import '../provider/recipes.provider.dart';
import '../utils/navigation.utils.dart';
import '../utils/toast.message.utils.dart';
import '../utils/toast.status.dart';
import 'card.recipe.vertical.dart';
class FiltterRecipes extends StatefulWidget {
   FiltterRecipes({super.key,required this .valueselected});
    Map<String,dynamic> valueselected ;
  @override
  State<FiltterRecipes> createState() => _FiltterRecipesState();
}

class _FiltterRecipesState extends State<FiltterRecipes> {
  @override
  void initState() {
    Provider.of<RecipesProvider>(context, listen: false).getFilteredResult(widget.valueselected,context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(
          leading: IconButton(
              onPressed: () {
                NavigationUtils.push(context: context, page: SideMenuPage());
              },
              icon: Icon(Icons.sort)),
          actions: [
            IconButton(
                onPressed: () {
                  NavigationUtils.push(
                      context: context, page: NotificationPage());
                },
                icon: Icon(Icons.notifications)),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderBar(title: "Filters Recipes", titleRight: ""),
              SizedBox(height: 10,),
              Consumer<RecipesProvider>(builder: (context, value, child) {
                print(
                 "==@@@@@@@@@@@@@@@@@@@@@@@@@2filtter = ${value.filtterRecipesList}====================");

                 //  value.getFilteredResult(widget.valueselected,context);

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
                            padding: const EdgeInsets.only(bottom: 5,right: 5,left: 10),
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
                else if (value.filtterRecipesList.isEmpty) {

                 // ToastMessageUtils.showToastMessage(context, ToastStatus.failed, "No recipes matched the filter criteria.");
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("No recipes matched the filter criteria.",style: TextStyle(fontSize: 18,color: Colors.deepOrange,fontWeight:FontWeight.w500 ),),
                  );
                } else
                  return Container(
                    child: Image.asset("assets/images/loading.gif"),
                  );

              }),
            ],
          ),
        ),
      )
      ,);
  }
}
