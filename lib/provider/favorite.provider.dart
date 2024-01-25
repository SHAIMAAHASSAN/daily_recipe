

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:overlay_kit/overlay_kit.dart';

import '../models/favorite.model.dart';

class FavoriteProvider extends ChangeNotifier{
 Recipe? favoriteRecipe;
  List<Recipe> recipe = [];

  void init(BuildContext context){
    favoriteRecipe=Recipe();
   // getFavoriteRecipes(context);
    notifyListeners();
  }

  Future<void> getFavoriteRecipes(BuildContext context,String recipeId) async {
    try {
      OverlayLoadingProgress.start();
      var result = await FirebaseFirestore.instance.
      collection("favoriteRecipes").doc(
          FirebaseAuth.instance.currentUser?.uid ?? "").get();

      print("=======================> result= ${result.exists} =================>");
      print("=======================> result= ${result} =================>");

      if (result.exists) {
      var x=  await FirebaseFirestore.instance.
        collection("favoriteRecipes").doc(
            FirebaseAuth.instance.currentUser?.uid ?? "").update({
            'favoriteRecipes':  FieldValue.arrayUnion([favoriteRecipe?.toJson()])}
        );

      notifyListeners();
      }
      else{
        await FirebaseFirestore.instance.
        collection("favoriteRecipes").doc(
            FirebaseAuth.instance.currentUser?.uid ?? "").set({
          'favoriteRecipes':[favoriteRecipe?.toJson()]}
        );
        notifyListeners();
      }
      OverlayLoadingProgress.stop();
    }
    catch (e) {
        OverlayLoadingProgress.stop();



      }
    }


}