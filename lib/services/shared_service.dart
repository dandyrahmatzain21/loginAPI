import 'dart:convert';

import 'package:survei_asia/models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("login_details") != null ? true : false;
  }

  static Future<LoginResponse?> loginDetails() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("login_details") != null ? LoginResponse.fromJson(jsonDecode(prefs.getString("login_details")!)) : null;
  }

  static Future<void> setLoginDetails(LoginResponse model) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("login_details", jsonEncode(model.toJson()));
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}