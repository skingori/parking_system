import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class AppSharedPreferences {
  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

///////////////////////////////////////////////////////////////////////////////
  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> setUserLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(SharedPreferenceKeys.isUserLoggedIn, isLoggedIn);
  }

  //fetch data from shared preference

  static Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferenceKeys.isUserLoggedIn) ?? false;
  }

  static Future<bool> setUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(SharedPreferenceKeys.userToken, token);
  }

  static Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferenceKeys.userToken);
  }

  static Future<bool> setUserName(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(SharedPreferenceKeys.userLevel, username);
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferenceKeys.userLevel);
  }
}

class JWTdecode {
  getJWTdecode() async {
    String? token = await AppSharedPreferences.getUserToken();
    Map<String, dynamic> payload = Jwt.parseJwt(token!);
    bool isExpired = Jwt.isExpired(token);
    return {
      "id": payload["Login_id"],
      "username": payload["username"],
      "status": !isExpired,
      "token": token,
      "exp": payload["exp"],
    };
  }
}
