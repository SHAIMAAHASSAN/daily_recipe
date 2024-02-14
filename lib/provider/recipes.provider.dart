import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:daily_recipe/utils/toast.message.utils.dart';
import 'package:daily_recipe/utils/toast.status.dart';
import 'package:overlay_kit/overlay_kit.dart';

class RecipesProvider extends ChangeNotifier {
  List<Recipe> _recipesList = [];
  List<Recipe> get recipesList => _recipesList;
  List<Recipe> _filterRecipesList = [];
  List<Recipe> get filterRecipesList => _filterRecipesList;
  List<Recipe> _freshRecipesList = [];
  List<Recipe> get freshRecipesList => _freshRecipesList;
  List<Recipe> _recommendRecipesList = [];
  List<Recipe> get recommendRecipesList => _recommendRecipesList;
  List<Recipe> _favoriteRecipesList = [];
  List<Recipe> get favoriteRecipesList => _favoriteRecipesList;
  List<Recipe> _viewedRecipesList = [];
  List<Recipe> get viewedRecipesList => _viewedRecipesList;

  void getFilteredResult(
      Map<String, dynamic> value, BuildContext context) async {
    var ref = FirebaseFirestore.instance.collection('recipes');

    Query<Map<String, dynamic>> query = ref;
    for (var entry in value.entries) {
      query = query.where(entry.key, isEqualTo: entry.value);
    }
    try {
      OverlayLoadingProgress.start();
      var result = await query.get();

      _filterRecipesList = List<Recipe>.from(
          result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));

      OverlayLoadingProgress.stop();
      notifyListeners();
    } catch (error) {
      OverlayLoadingProgress.stop();
      if (context.mounted) {
        ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
            "Error fetching filtered recipes: $error");
      }
    }
  }

  Future<void> getRecipes(BuildContext context) async {
    try {
      /* var resultTest = await FirebaseFirestore.instance
          .collection('recipes')
          .get()
          .then((value) => value.docs.forEach((doc) {
                print(doc["serving"]);
              }));*/
      var result = await FirebaseFirestore.instance.collection('recipes').get();
      if (result.docs.isNotEmpty) {
        _recipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      }

      notifyListeners();
    } on StateError catch (e) {
      switch (e) {
        case 'PERMISSION_DENIED':
          if (context.mounted) {
            ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
                'User does not have permission to access this data.');
          }
          break;
        case 'NOT_FOUND':
          if (context.mounted) {
            ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
                'The document or collection does not exist.');
          }
          print('The document or collection does not exist.');
          break;
        case 'UNAVAILABLE':
          if (context.mounted) {
            ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
                'Firestore is currently unavailable.');
          }
          break;
        default:
          if (context.mounted) {
            ToastMessageUtils.showToastMessage(
                context, ToastStatus.failed, 'An unknown error occurred: ${e}');
          }
          print('An unknown error occurred: $e');
          break;
      }
      _recipesList = [];
      notifyListeners();
    }
  }

  Future<void> getFreshRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('isFresh', isEqualTo: true)
          .limit(5)
          .get();

      if (result.docs.isNotEmpty) {
        _freshRecipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _freshRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      _freshRecipesList = [];
      notifyListeners();
    }
  }

  Future<void> getRecommandedRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('isFresh', isEqualTo: false)
          .limit(5)
          .get();
      if (result.docs.isNotEmpty) {
        _recommendRecipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _recommendRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      _recommendRecipesList = [];
      notifyListeners();
    }
  }

  Future<void> addFavoriteRecipesToUser(
      String recipeId, bool isAdd, BuildContext context) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "user_ids":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "user_ids":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      //  if(context.mounted){
      await _updateRecipe(recipeId);
      //}
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();
      if (context.mounted) {
        ToastMessageUtils.showToastMessage(
            context, ToastStatus.failed, "Error : ${e.toString()}");
      }
    }
  }

  Future<void> _updateRecipe(String recipeId) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .get();
      Recipe? updatedRecipe;
      if (result.data() != null) {
        updatedRecipe = Recipe.fromJson(result.data()!, result.id);
      } else {
        return;
      }

      var recipesListIndex =
          recipesList.indexWhere((recipe) => recipe.docId == recipeId);

      if (recipesListIndex != -1) {
        recipesList.removeAt(recipesListIndex);
        recipesList.insert(recipesListIndex, updatedRecipe);
      }

      var freshRecipesListIndex =
          freshRecipesList?.indexWhere((recipe) => recipe.docId == recipeId);

      if (freshRecipesListIndex != -1) {
        freshRecipesList?.removeAt(freshRecipesListIndex!);
        freshRecipesList?.insert(freshRecipesListIndex!, updatedRecipe);
      }

      var recommandedRecipesListIndex = recommendRecipesList
          ?.indexWhere((recipe) => recipe.docId == recipeId);

      if (recommandedRecipesListIndex != -1) {
        recommendRecipesList?.removeAt(recommandedRecipesListIndex!);
        recommendRecipesList?.insert(
            recommandedRecipesListIndex!, updatedRecipe);
      }

      notifyListeners();
    } catch (e) {
      print("Error in update recipe: ${e.toString()}");
      /* if(context.mounted){
        ToastMessageUtils.showToastMessage(
            context, ToastStatus.failed, "Error in update recipe: ${e.toString()}");
      }*/
    }
  }

  Future<void> addViewedRecipesToUser(
      String recipeId, BuildContext context) async {
    try {
      OverlayLoadingProgress.start();
      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .update({
        "viewed_ids":
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
      });
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();
      if (context.mounted) {
        ToastMessageUtils.showToastMessage(
            context, ToastStatus.failed, "Error : ${e.toString()}");
      }
    }
  }

  Future<void> clearViewedRecipes(String recipeId) async {
    await FirebaseFirestore.instance
        .collection('recipes')
        .doc(recipeId)
        .update({
      "viewed_ids":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
    });
  }

  Future<void> getFavoriteRecipes() async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes').get();

      if (result.docs.isNotEmpty) {
        _favoriteRecipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));

     //   notifyListeners();
      } else {
        _favoriteRecipesList = [];
     //   notifyListeners();
      }
    } catch (e) {
      _favoriteRecipesList = [];
    //  notifyListeners();
    }
    notifyListeners();
  }

  Future<void> getViewedRecipes() async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes').get();

      if (result.docs.isNotEmpty) {
        _viewedRecipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));

      //  notifyListeners();
      } else {
        _viewedRecipesList = [];
       // notifyListeners();
      }
    } catch (e) {
      _viewedRecipesList = [];
     // notifyListeners();
    }
    notifyListeners();
  }

  void initRecipes(BuildContext context) {
    getRecipes(context);
    getFreshRecipes();
    getRecommandedRecipes();
    notifyListeners();
  }

  @override
  void dispose() {
    _filterRecipesList = [];
    // TODO: implement dispose
    super.dispose();
  }
}
