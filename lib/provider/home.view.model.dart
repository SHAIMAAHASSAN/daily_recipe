import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/ad.model.dart';
import '../models/recipe.model.dart';
import '../services/ads.services.dart';


class HomeViewModel extends ChangeNotifier{
  int currentIndex =0;
  List<Ad>  adsList= [];
  List<Recipe> recipeList = [];
 /* void getAds() async {
    var adsData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
    List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);

   adsList = dataDecoded.map((e) => Ad.fromJson(e)).toList();

  notifyListeners();

  }*/

  void fetchAds() async {
    try {
      List<Ad> adslist = await  (FetchData.fetchAdsFromJson());
      adsList.addAll(adslist);
    } catch (error) {
      print("===============$error==============");
    }
    notifyListeners();
  }


  void getRecipe() async {
    try {
      List<Recipe> recipes = await  (FetchData.fetchRecipesFromJson());
      recipeList.addAll(recipes);
    } catch (error) {
      print("===============$error==============");
    }
    notifyListeners();
   /* var recipeData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
    List<Map<String, dynamic>>.from(jsonDecode(recipeData)["recipes"]);

    recipeList = dataDecoded.map((e) => Recipe.fromJson(e)).toList();

    print("***************************");
    print(recipeList[0].title);
    notifyListeners();*/
  }

  void initHomePage(){
    getRecipe();
    fetchAds();
    notifyListeners();

  }



  void changeIndex(int index) {
   currentIndex =index ;
   notifyListeners() ;
  }




}