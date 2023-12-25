import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencService {
  static SharedPreferences? prefs;

  static initPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  static bool isLoggedIn() {
    return prefs?.containsKey('email') ?? false;
  }

  static saveUsernameData(String name) async {
    await PreferencService.initPrefs();
    // prefs?.setString('username', username);
    prefs?.setString('username', name);
    // Consider secure encryption for password
  }

  static saveLoginData(String email, String password) async {
    await PreferencService.initPrefs();
    // prefs?.setString('username', username);
    prefs?.setString('email', email);
    prefs?.setString(
        'password', password); // Consider secure encryption for password
  }

  static bool checkUser() {
    return prefs?.getBool('isLogin') ?? false;
  }

  static loginData() async {
    await PreferencService.initPrefs();
    return prefs?.getString('email');
    // Consider secure encryption for password
  }

  static loginNameData() async {
    await PreferencService.initPrefs();
    return prefs?.getString('username');
    // Consider secure encryption for password
  }

  static logout() async {
    await PreferencService.initPrefs();
    prefs?.remove('email');
    prefs?.remove('password');
    prefs?.remove('username');

  }
}
