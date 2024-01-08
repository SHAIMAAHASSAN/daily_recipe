import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/services.dart';

import '../models/ad.model.dart';
import '../services/ads.services.dart';
//import 'package:equatable/equatable.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsState(0));

  final List<Ad> ads = [];

  final CarouselController carouselControllerEx = CarouselController();


  void fetchAds() async {
    try {
      List<Ad> adslist = await  (FetchAds.fetchAdsFromJson());
      ads.addAll(adslist);
    } catch (error) {
      print("===============$error==============");
    }
  }

  void changeIndex(int index) {
    state.currentIndex =index ;
        emit(AdsState(state.currentIndex)) ;
  }
}
