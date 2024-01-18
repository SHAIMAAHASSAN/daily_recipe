//import 'dart:js';

import 'package:daily_recipe/cubit/ads_cubit.dart';
import 'package:daily_recipe/pages/splash.page.dart';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/provider/auth.Provider.dart';
import 'package:daily_recipe/provider/home.view.model.dart';
import 'package:daily_recipe/services/preference.services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(
/*    options: const FirebaseOptions(
      apiKey: " ",//  ==   current_key in google-services.json file
      appId: " ", // ==  mobilesdk_app_id  in google-services.json file
      messagingSenderId: " ", // ==   project_number in google-services.json file
      projectId: " ", // ==   project_id   in google-services.json file
    ),*/
  );

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

 /*   var preferenceGetIt = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(preferenceGetIt);*/

    // var preference = await SharedPreferences.getInstance();

    //if (PreferencService.initPrefs() != null) {
    print("========> Sucessful Run =======>");
    // }
  } catch (e) {
    print("============> Exception error $e ==========>");
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=> HomeViewModel()..initHomePage(),),
      ChangeNotifierProvider(create: (context)=> AuthProviderViewModel(),),

    ],
    child: const MyApp()),


  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
     // BlocProvider.value(
      
        //value: AdsCubit()..fetchAds(),
     // child:
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Hellix',
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const SplahScreen(),
     // ),
    );
  }
}
