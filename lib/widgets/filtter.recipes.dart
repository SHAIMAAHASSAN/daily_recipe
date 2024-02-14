import 'package:animated_list_item/animated_list_item.dart';
import 'package:daily_recipe/widgets/header.bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/notification.page.dart';
import '../pages/recipe.view.page.dart';
import '../pages/side.menu.page.dart';
import '../provider/recipes.provider.dart';
import '../utils/navigation.utils.dart';
import 'card.recipe.vertical.dart';

class FilterRecipes extends StatefulWidget {
 const FilterRecipes({super.key, required this.valueSelected});
 final Map<String, dynamic> valueSelected;
  @override
  State<FilterRecipes> createState() => _FilterRecipesState();
}

class _FilterRecipesState extends State<FilterRecipes>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    Provider.of<RecipesProvider>(context, listen: false)
        .getFilteredResult(widget.valueSelected, context);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _animationController.forward();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                NavigationUtils.push(
                    context: context, page: const SideMenuPage());
              },
              icon: const Icon(Icons.sort)),
          actions: [
            IconButton(
                onPressed: () {
                  NavigationUtils.push(
                      context: context, page: const NotificationPage());
                },
                icon: const Icon(Icons.notifications)),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
               HeaderBar(title: "Filters Recipes".tr(), titleRight: ""),
              const SizedBox(
                height: 10,
              ),
              Consumer<RecipesProvider>(builder: (context, value, child) {
                if (value.filterRecipesList.isNotEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.filterRecipesList.length,
                        itemBuilder: (context, index) {
                          return AnimatedListItem(
                            index: index,
                            length: value.filterRecipesList.length,
                            aniController: _animationController,
                            animationType: AnimationType.flipX,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 5, right: 5, left: 10),
                              child: GestureDetector(
                                  onDoubleTap: () {
                                    NavigationUtils.push(
                                        context: context,
                                        page: RecipeViewPage(
                                            recipe: value
                                                .filterRecipesList[index]));
                                  },
                                  child: CardRecipeVertical(
                                      recipe: value.filterRecipesList[index])),
                            ),
                          );
                        }),
                  );
                } else if (value.filterRecipesList.isEmpty) {
                  return  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: const Text(
                      "No recipes matched the filter criteria.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w500),
                    ).tr(),
                  );
                } else
                  return Image.asset("assets/images/loading.gif");
              }),
            ],
          ),
        ),
      ),
    );
  }
}
