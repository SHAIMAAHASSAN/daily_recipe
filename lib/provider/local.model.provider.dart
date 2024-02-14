import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class LocaleLanguage extends ChangeNotifier {
  Locale _locale = const Locale('en', 'US'); // Initial locale
  Locale get locale => _locale;

  setLocale(Locale locale,BuildContext context) async {
    await context.setLocale(locale);
    if(context.mounted){
    _locale =context.locale;}
    notifyListeners();
  }
}