// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC1OFwW4AB8SatIJzZ3DdYiKHsz16JMdVY',
    appId: '1:1078691183331:web:9ff0ceb3648acfeec2a3d6',
    messagingSenderId: '1078691183331',
    projectId: 'recipe-app-3413d',
    authDomain: 'recipe-app-3413d.firebaseapp.com',
    storageBucket: 'recipe-app-3413d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmdwCV46WjB845tEgoJABZj2CtRHrEqX8',
    appId: '1:1078691183331:android:f1ef1213301571e6c2a3d6',
    messagingSenderId: '1078691183331',
    projectId: 'recipe-app-3413d',
    storageBucket: 'recipe-app-3413d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmkveqrpj-D05f4DNx4F3qTdV8UsFsmuI',
    appId: '1:1078691183331:ios:f2afef99706852a2c2a3d6',
    messagingSenderId: '1078691183331',
    projectId: 'recipe-app-3413d',
    storageBucket: 'recipe-app-3413d.appspot.com',
    iosBundleId: 'com.example.dailyRecipe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBmkveqrpj-D05f4DNx4F3qTdV8UsFsmuI',
    appId: '1:1078691183331:ios:2d5c0ba4c0fca1f9c2a3d6',
    messagingSenderId: '1078691183331',
    projectId: 'recipe-app-3413d',
    storageBucket: 'recipe-app-3413d.appspot.com',
    iosBundleId: 'com.example.dailyRecipe.RunnerTests',
  );
}
