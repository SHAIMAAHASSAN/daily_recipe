//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:daily_recipe/pages/splash.page.dart';
import 'package:daily_recipe/provider/auth.Provider.dart';
import 'package:daily_recipe/provider/ads.provider.dart';
import 'package:daily_recipe/provider/ingredients.provider.dart';
import 'package:daily_recipe/provider/local.model.provider.dart';
import 'package:daily_recipe/provider/recipes.provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("============> Exception error $e ==========>");
  }

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AdsProvider()..initAds(),
          ),
          ChangeNotifierProvider(
              create: (context) => RecipesProvider()..initRecipes(context)),
          ChangeNotifierProvider(
            create: (context) => AuthProviderViewModel()..initAuth(),
          ),
          ChangeNotifierProvider(
            create: (context) => IngredientsProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LocaleLanguage(),
          ),
        ],
        child: EasyLocalization(
            supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
            path: 'assets/translations',
            child: const MyApp())),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlayKit(
        child: Consumer<LocaleLanguage>(
            builder: (context, model, child) => MaterialApp(
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: model.locale,
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    fontFamily: 'Hellix',
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                    useMaterial3: true,
                  ),
                  home: const SplahScreen(),
                  // ),
                )));
  }
}
