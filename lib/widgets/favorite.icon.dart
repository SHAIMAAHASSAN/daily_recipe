import 'package:daily_recipe/models/favorite.model.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:daily_recipe/provider/favorite.provider.dart';
import 'package:daily_recipe/utils/toast.status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/recipes.provider.dart';
import '../utils/toast.message.utils.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({super.key, required this.recipe});
  final Recipe? recipe;

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool get isInList => (widget.recipe?.user_ids
      ?.contains(FirebaseAuth.instance.currentUser?.uid) ??
      false);

  @override
  void initState() {
    Provider.of<RecipesProvider>(context, listen: false).getFavoriteRecipes();

    // TODO: implement initState
   /* isfavorite= Provider.of<RecipesProvider>(context, listen: false).
    recipesList[widget.currentIndex].user_ids!.
    contains(FirebaseAuth.instance.currentUser?.uid);*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipesProvider>(builder: (context, value, child) {
      /*print(
          "==@@@@@@@@@@@@@@@@@@@@@@@@@2Recipes = ${value.recipesList}====================");*/

      if (value.recipesList.isNotEmpty) {

       /* isfavorite= Provider.of<RecipesProvider>(context, listen: false).
        recipesList[widget.currentIndex].user_ids!.
        contains(FirebaseAuth.instance.currentUser?.uid);

        print("////////////////////////////isfavorite=$isfavorite");*/
        /*ToastMessageUtils.showToastMessage(
            context, ToastStatus.success, "Enjoy with our recipes.");*/

        return InkWell(
          onTap: () {

               value.addFavoriteRecipesToUser(widget.recipe!.docId!,
                   !isInList, context);



               if (isInList) {
                 widget.recipe?.user_ids
                     ?.remove(FirebaseAuth.instance.currentUser?.uid);
               } else {
                 widget.recipe?.user_ids
                     ?.add(FirebaseAuth.instance.currentUser!.uid);
               }

               setState(() {});




           /* String recipeId= value.recipesList[widget.currentIndex].docId!;
            isfavorite = !isfavorite;
          value.addFavoriteRecipesToUser(
              value.recipesList[widget.currentIndex].docId!,
               isfavorite,
               context) ;
            print("=================recipeId=${recipeId}========================");*/

            /*  ==============================Using FavoriteProvider I have problem get null values of Recipe ======================*/
            /*Provider.of<FavoriteProvider>(context, listen: false)
                .getFavoriteRecipes( context,value.recipesList[widget.currentIndex].docId!);*/
            //==========================================================================================

            //value.getFavoriteRecipes();


          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ( isInList
                ? const Icon(
              Icons.favorite,
              size: 25,
              color: Colors.deepOrange,
            )
                : const Icon(
              Icons.favorite_border,
              size: 25,
              color: Colors.grey,
            ))),


            /*Icon(isfavorite ? Icons.favorite : Icons.favorite_border,
                color: isfavorite ? Colors.deepOrange : Colors.grey,
                //color: _color,
                size: 25),*/
         // ),
        );
      }
      return Container(
        child: Image.asset("assets/images/loading.gif"),
      );
    });
  }
}
