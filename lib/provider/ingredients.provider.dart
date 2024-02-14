import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/utils/toast.message.utils.dart';
import 'package:daily_recipe/utils/toast.status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

import '../models/ingredients.dart';

class IngredientsProvider extends ChangeNotifier {
  List<Ingredient>? _ingredientsList;
  List<Ingredient>? get ingredientsList => _ingredientsList;

  Future<void> getIngredients() async {
    try {
      var result =
      await FirebaseFirestore.instance.collection('userIngredients').get();

      if (result.docs.isNotEmpty) {
        _ingredientsList = List<Ingredient>.from(
            result.docs.map((doc) => Ingredient.fromJson(doc.data(), doc.id)));
      } else {
        _ingredientsList = [];
      }
      notifyListeners();
    } catch (e) {
      _ingredientsList = [];
      notifyListeners();
    }
  }

  Future<void> addIngredientToUser(String ingredientId, bool isAdd,BuildContext context) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('userIngredients')
            .doc(ingredientId)
            .update({
          "usersIng_ids":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('userIngredients')
            .doc(ingredientId)
            .update({
          "usersIng_ids":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      OverlayLoadingProgress.stop();
      getIngredients();
    } catch (e) {
      OverlayLoadingProgress.stop();
      if(context.mounted){
      ToastMessageUtils.showToastMessage(context, ToastStatus.failed, 'Error : ${e.toString()}');}

    }
  }

}