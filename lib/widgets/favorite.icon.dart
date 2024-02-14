
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/recipes.provider.dart';


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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipesProvider>(builder: (context, value, child) {
      if (value.recipesList.isNotEmpty) {

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
        );
      }
      return Image.asset("assets/images/loading.gif");
    });
  }
}
