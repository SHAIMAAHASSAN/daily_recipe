
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/ad.model.dart';

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

      } else {
        _adsList = [];
      }
      notifyListeners();
    } catch (e) {
      _adsList = [];
      notifyListeners();
    }
  }




  void initAds(){
    fetchAds();
    notifyListeners();

  }


  void changeIndex(int index) {
   currentIndex =index ;
   notifyListeners() ;
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}