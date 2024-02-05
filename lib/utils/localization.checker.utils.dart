import 'package:daily_recipe/pages/home.page.dart';
import 'package:daily_recipe/pages/splash.page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LocalizationChecker {
  static changeLanguge(BuildContext context) {
    Locale? currentLocal = EasyLocalization.of(context)!.currentLocale;
    if (currentLocal == const Locale('en', 'US')) {
      EasyLocalization.of(context)!.setLocale(const Locale('ar', 'EG'));
    } else {
      EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
    }


  }
}