import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:flutter/material.dart';
import 'package:daily_recipe/utils/toast.message.utils.dart';
import 'package:daily_recipe/utils/toast.status.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_kit/overlay_kit.dart';
import '../services/ads.services.dart';
import '../utils/toast.message.utils.dart';

class RecipesProvider extends ChangeNotifier {
  //List<Recipe>recipesList=[];
  List<Recipe> _recipesList = [];
  List<Recipe> get recipesList => _recipesList;
  List<DocumentSnapshot> _cachedData = [];

  List<DocumentSnapshot> get cachedData => _cachedData;

  Future<void> fetchData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('recipes')
        .get();

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
          ToastMessageUtils.toastMessage(context, ToastStatus.failed,
              'User does not have permission to access this data.');
          print('User does not have permission to access this data.');
          break;
        case 'NOT_FOUND':
          ToastMessageUtils.toastMessage(context, ToastStatus.failed,'The document or collection does not exist.');
          print('The document or collection does not exist.');
          break;
        case 'UNAVAILABLE':
          print('Firestore is currently unavailable.');
          ToastMessageUtils.toastMessage(context, ToastStatus.failed,'Firestore is currently unavailable.');
          break;
        default:
              ToastMessageUtils.toastMessage(context, ToastStatus.failed,'An unknown error occurred: ${e}');
          print('An unknown error occurred: ${e}');
          break;
      }
      _recipesList = [];
      notifyListeners();
    }
  }

  void initRecipes(BuildContext context) {
    getRecipes(context);
    notifyListeners();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
