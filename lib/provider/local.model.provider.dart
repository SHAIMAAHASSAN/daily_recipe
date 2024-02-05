import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class LocaleModel extends ChangeNotifier {
  Locale _locale = const Locale('en', 'US'); // Initial locale
  Locale get locale => _locale;

  setLocale(Locale locale,BuildContext context) async {
    await context.setLocale(locale);
    if(context.mounted){             // Use easy_localization's method
    _locale =context.locale;}
    notifyListeners();
  }
}