import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/ad.model.dart';

abstract class FetchAds{

   static Future<List<Ad>> fetchAdsFromJson() async {
    final adsData = await rootBundle.loadString('assets/data/sample.json');
    final dataDecoded  = List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
    final List<Ad> ads = dataDecoded.map((ad) => Ad.fromJson(ad)).toList();
    return ads;
  }


}





