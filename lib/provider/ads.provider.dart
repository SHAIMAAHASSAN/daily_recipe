import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/ad.model.dart';
import '../models/recipe.model.dart';
import '../services/ads.services.dart';


class AdsProvider extends ChangeNotifier{
  int currentIndex =0;
  List<Ad> _adsList=[];

  List<Ad> get adsList => _adsList;


  void fetchAds() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('ads')
          .get();

      if (result.docs.isNotEmpty) {
        _adsList = List<Ad>.from(
            result.docs.map((doc) => Ad.fromJson(doc.data(), doc.id)));
        print("***********************AdsFromFirestore=$_adsList**************************");
      } else {
        _adsList = [];
      }
      notifyListeners();
    } catch (e) {
      _adsList = [];
      notifyListeners();
    }
  }




  void initHomePage(){
   // getRecipe();
    fetchAds();
    notifyListeners();

  }


  void changeIndex(int index) {
   currentIndex =index ;
   notifyListeners() ;
  }


}