import 'dart:convert';

import 'package:daily_recipe/models/recipe.model.dart';
import 'package:flutter/services.dart';

import '../models/ad.model.dart';

abstract class FetchData {

  static Future<List<Ad>> fetchAdsFromJson() async {
    final adsData = await rootBundle.loadString('assets/data/sample.json');
    final dataDecoded = List<Map<String, dynamic>>.from(
        jsonDecode(adsData)['ads']);
    final List<Ad> ads = dataDecoded.map((ad) => Ad.fromJson(ad)).toList();
    return ads;
  }


  static Future<List<Recipe>> fetchRecipesFromJson() async {
    final recipeData = await rootBundle.loadString('assets/data/sample.json');
    final dataDecoded = List<Map<String, dynamic>>.from(
        jsonDecode(recipeData)["recipes"]);
    final List<Recipe> recipes = dataDecoded.map((recipe) =>
        Recipe.fromJson(recipe)).toList();
    return recipes;
  }

}





