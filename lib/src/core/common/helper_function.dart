import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  /**
   * Keys
   */

  static String _userLogingKey = 'LOGGINKEY';
  static String _userNameKey = 'USERNAMEKEY';
  static String _userEmailKey = 'USEREMAILKEY';
  static String _userIDKey = 'UID';
  static String theme = "isDarkMode";
   static String Token = "_NjadiaToken";

  /**
   * saving to share preferences
   */

  static Future<bool> writeTokne(value) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
   return await sharedPreference.setString(Token, value);
  }


  static Future<bool> writeTheme(value) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
   return await sharedPreference.setBool(theme, value);
  }


   // getting data
  static Future<bool> getTheme() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.getBool(theme)!;
  }

  static Future<bool> saveUserLoggInState(bool isLoggedIn) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setBool(_userLogingKey, isLoggedIn);
  }

  static Future<bool> saveUserName(String userName) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setString(_userNameKey, userName);
  }

  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setString(_userEmailKey, userEmail);
  }


  static Future<bool> saveUserID(String id) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setString(_userIDKey, id);
  }

  // getting data

  static Future<String> getUserToken() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.getString(Token)!;
  }



  static Future<String> getUserEmail() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.getString(_userEmailKey)!;
  }

  static Future<String> getUserName() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.getString(_userEmailKey)!;
  }


  static Future<String> getUserID() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.getString(_userIDKey)!;
  }
  /**
   * Getting data from shared preferences
   */

  static Future<bool> getUserLoggedInData() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    return sharedPreference.getBool(_userLogingKey)!;
  }
}

const textInputDecoration = InputDecoration(
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffee3b6d), width: 2)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2)));

void nextScreen(BuildContext context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(BuildContext context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackMessage(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("$message"),
      backgroundColor: color,
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: "Ok",
        onPressed: () {},
      ),
    ),
  );
}
