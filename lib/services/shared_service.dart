import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wpandflutterconnect/model/login_model.dart';

class SharedService {
  static Future<bool?> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
  }

  static Future<LoginResponseModel?> loginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('login_details') != null
        ? LoginResponseModel.fromJson(
            jsonDecode(
              prefs.getString('login_details').toString(),
            ),
          )
        : null;
  }

  static Future<void> setLoginDetails(LoginResponseModel responseModel) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'login_details',
        (responseModel != null
                ? jsonEncode(
                    responseModel.toJson(),
                  )
                : null)
            .toString());
  }

  static Future<void> logout(BuildContext context) async {
    await setLoginDetails(null!);
    Navigator.of(context).pushReplacementNamed('/login');
  }
}
