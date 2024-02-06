import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:daily_recipe/utils/toast.message.utils.dart';
import 'package:daily_recipe/utils/toast.status.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_kit/overlay_kit.dart';
import '../services/ads.services.dart';
import '../utils/toast.message.utils.dart';
import '../widgets/toast.message.dart';

class RecipesProvider extends ChangeNotifier {
  //List<Recipe>recipesList=[];
  List<Recipe> _recipesList = [];
  List<Recipe> get recipesList => _recipesList;
  List<Recipe> _filtterRecipesList = [];
  List<Recipe> get filtterRecipesList => _filtterRecipesList;
  List<Recipe> _freshrecipesList = [];
  List<Recipe> get freshrecipesList => _freshrecipesList;
  List<Recipe> _recommendrecipesList = [];
  List<Recipe> get recommendRecipesList => _recommendrecipesList;
  List<Recipe> _favoriteRecipesList = [];
  List<Recipe> get favoriteRecipesList => _favoriteRecipesList;
  List<Recipe> _viewedRecipesList = [];
  List<Recipe> get viewedRecipesList => _viewedRecipesList;

  List<DocumentSnapshot> _cachedData = [];

  List<DocumentSnapshot> get cachedData => _cachedData;
  Map<String,dynamic> valueSelected={"meal_type": "SALAD", "serving": 4, "prep_time": 45, "calories": 230};


  void getFilteredResult(Map<String,dynamic> value,BuildContext context) async {
    var ref = FirebaseFirestore.instance.collection('recipes');

    Query<Map<String, dynamic>> query = ref;
    for (var entry in value.entries) {
      query = query.where(entry.key, isEqualTo: entry.value);
    }
     try{
      OverlayLoadingProgress.start();
       var result = await query.get();

       print("===========value=${value}========================");
       print("===========resultofQuery=${result.docs}========================");

       //if (result.docs.isNotEmpty) {

       _filtterRecipesList = List<Recipe>.from(
           result.docs.map((doc) => Recipe.fromJson(doc.data() , doc.id)));
   // }

      /* else {
         ToastMessageUtils.showToastMessage(context, ToastStatus.failed, "No recipes matched the filter criteria.");
         print("No recipes matched the filter criteria.");
         // Handle the empty list appropriately
       }*/
      OverlayLoadingProgress.stop();
       notifyListeners();


     }
     catch (error) {
        OverlayLoadingProgress.stop();
       ToastMessageUtils.showToastMessage(context, ToastStatus.failed, "Error fetching filtered recipes: $error");
       print("Error fetching filtered recipes: $error");
       // Handle the error appropriately
     }

  }


  Future<void> fetchData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('recipes').get();

    _cachedData = snapshot.docs;
    notifyListeners();
  }

// Add methods for updating cached data based on Firestore changes

  Future<void> getRecipes(BuildContext context) async {
    try {
      var resultTest = await FirebaseFirestore.instance
          .collection('recipes')
          .get()
          .then((value) => value.docs.forEach((doc) {
                print(doc["serving"]);
              }));
      var result = await FirebaseFirestore.instance.collection('recipes').get();
      print(
          "============================resultdocvalue=${(result.docs)}==============");
      print(
          "============================resultdocCheck=${(result.docs.isNotEmpty)}==============");
      if (result.docs.isNotEmpty) {
        _recipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));

        print(
            "============================recipeListFromFireStore=${(_recipesList)}==============");
      }

      notifyListeners();

      /*???????????????????? why write this Don't use 'BuildContext's across async gaps,how solve it ?????????*/
    } on StateError catch (e) {
      // Handle potential Firestore exceptions
      switch (e) {
        case 'PERMISSION_DENIED':
          if (context.mounted) {
            ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
                'User does not have permission to access this data.');
          }
          print('User does not have permission to access this data.');
          break;
        case 'NOT_FOUND':
          if (context.mounted) {
            ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
                'The document or collection does not exist.');
          }
          print('The document or collection does not exist.');
          break;
        case 'UNAVAILABLE':
          print('Firestore is currently unavailable.');
          //const ToastMessageWidget(toastStatus: ToastStatus.success,
          // message:'Firestore is currently unavailable.');
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
          print('An unknown error occurred: ${e}');
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
        _freshrecipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _freshrecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      _freshrecipesList = [];
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
        _recommendrecipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _recommendrecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      _recommendrecipesList = [];
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

       /* await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({"favorite": true});*/


      } else {
      /*  await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({"favorite": false});*/

        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "user_ids":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });

      }
      await _updateRecipe(recipeId);
      OverlayLoadingProgress.stop();

    //  getRecipes(context);

      print(
          "66666666666666666666favorite= ${ _updateRecipe(recipeId)}666666666666666666666666666666");
    } catch (e) {
      OverlayLoadingProgress.stop();
      ToastMessageUtils.showToastMessage(
          context, ToastStatus.failed, "Error : ${e.toString()}");
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
      freshrecipesList?.indexWhere((recipe) => recipe.docId == recipeId);

      if (freshRecipesListIndex != -1) {
        freshrecipesList?.removeAt(freshRecipesListIndex!);
        freshrecipesList?.insert(freshRecipesListIndex!, updatedRecipe);
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
      print('>>>>>error in update recipe');
    }
  }

  Future<void> addViewedRecipesToUser(
      String recipeId/*, bool isAdd,*/ ,BuildContext context) async {
    try {
     OverlayLoadingProgress.start();
     // if (isAdd) {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "viewed_ids":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });


        /*await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({"isRead": true});*/
     // }
     /* else {

        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "viewed_ids":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });*/

       /* await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({"isRead": false});*/

     // }
      OverlayLoadingProgress.stop();

     // getRecipes(context);

      print(
          "66666666666666666666favorite= ${getRecipes(context)}666666666666666666666666666666");


    } catch (e) {
      OverlayLoadingProgress.stop();
      ToastMessageUtils.showToastMessage(
          context, ToastStatus.failed, "Error : ${e.toString()}");
    }
  }
  Future<void> clearViewedRecipes( String recipeId) async {



    await FirebaseFirestore.instance
        .collection('recipes')
        .doc(recipeId)
        .update({
      "viewed_ids":
      FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
    });

    /* await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({"isRead": false});*/

     }


  Future<void> getFavoriteRecipes() async {

    try {
    //  OverlayLoadingProgress.start();
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('favorite', isEqualTo: true)
      .get()
          ;


     if (result.docs.isNotEmpty) {

        _favoriteRecipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
        print(
            "ppppppppppppppppppppppp FavoriteRecipe=$_favoriteRecipesList pppppppppppppppppppppppppppp");

        notifyListeners();
      //  OverlayLoadingProgress.stop();
      } else {

        OverlayLoadingProgress.stop();
        _favoriteRecipesList = [];
      }
      //notifyListeners();
    } catch (e) {
      OverlayLoadingProgress.stop();
      _favoriteRecipesList = [];
      notifyListeners();
    }
  }
  Future<void> getViewedRecipes() async {

    try {
      //  OverlayLoadingProgress.start();
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('isRead', isEqualTo: true)
          .get()
      ;


      if (result.docs.isNotEmpty) {

        _viewedRecipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
        print(
            "5555555555555555555555555555555 viewedRecipesList=$_viewedRecipesList 55555555555555555555555555555");

        notifyListeners();
        //  OverlayLoadingProgress.stop();
      } else {

        OverlayLoadingProgress.stop();
        _favoriteRecipesList = [];
      }
      //notifyListeners();
    } catch (e) {
      OverlayLoadingProgress.stop();
      _favoriteRecipesList = [];
      notifyListeners();
    }
  }


  void initRecipes(BuildContext context) {
    getRecipes(context);
    //getFavoriteRecipes();
  //  getViewedRecipes();
    getFreshRecipes();
    getRecommandedRecipes();

    //getFilteredResult(valueSelected);
    notifyListeners();
  }

  @override
  void dispose() {
    _filtterRecipesList=[];
    // TODO: implement dispose
    super.dispose();
  }
}
