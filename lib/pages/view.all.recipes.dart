import 'package:daily_recipe/pages/recipe.view.page.dart';
import 'package:daily_recipe/provider/recipes.provider.dart';
import 'package:daily_recipe/widgets/card.recipe.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import '../utils/navigation.utils.dart';
class ViewAllRecipes extends StatefulWidget {
  const ViewAllRecipes({super.key});

  @override
  State<ViewAllRecipes> createState() => _ViewAllRecipesState();
}

class _ViewAllRecipesState extends State<ViewAllRecipes> {
  late ZoomDrawerController controller;

  @override
  void initState() {
    controller = ZoomDrawerController();
    Provider.of<RecipesProvider>(context, listen: false).getRecipes(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return /*ZoomDrawer(
        slideWidth: MediaQuery.of(context).size.width * 0.75,
        menuBackgroundColor: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
        disableDragGesture: true,
        mainScreenTapClose: true,
        showShadow: true,
        controller: controller,
        drawerShadowsBackgroundColor: Colors.grey,
        menuScreen: const SideMenuPage(),
        mainScreen:*/
      Scaffold(
        appBar: AppBar(title: const Text("Our Recipes").tr(),
        backgroundColor: Colors.brown[50],),
      /*  body: NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          pinned: false,
          floating: true,
          forceElevated: innerBoxIsScrolled,
          leading: IconButton(
              onPressed: () {
                controller.toggle!();
              },
              icon: const Icon(Icons.sort)),
          actions: [
            IconButton(
                onPressed: () {
                  NavigationUtils.push(
                      context: context, page: const NotificationPage());
                },
                icon: const Icon(Icons.notifications)),
          ],
        ),
      ];
    },*/
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<RecipesProvider>(
              builder: (context, value, child) =>
              value.recipesList == null
                  ? const CircularProgressIndicator()
                  : (value.recipesList?.isEmpty ?? false)
                  ? const Text('No Data Found')
                  : FlexibleGridView(
                axisCount: GridLayoutEnum.twoElementsInRow,
                crossAxisSpacing:10,
                mainAxisSpacing: 10,
                children:
                value.recipesList!
                    .map((e) => GestureDetector(onTap:
                    (){
                      NavigationUtils.push(context: context, page:
                      RecipeViewPage(recipe: e));

                    },


                      child: CardRecipe(recipe: e),
                    )
                )
                    .toList(),
              )),
        ))
    //)
   // )
    ;
  }
}
