import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/authentication/data/model/user_docs_response.dart';

class HelperFunction {
  /**
   * Keys
   */

  static String _userTelKey = 'TELKEY';
  static String _userLogingKey = 'LOGGINKEY';
  static String _userNameKey = 'USERNAMEKEY';
  static String _userEmailKey = 'USEREMAILKEY';
  static String _userIDKey = 'UID';
  static String _theme = "isDarkMode";
  static String _Token = "_NjadiaToken";
  static String _profilePic = "ProfilePic";
  static String _userNumberOfGroups = 'UserGroups';
  static String _userChats = 'UserChats';

  static String _userProfile = 'PROFILE';

  /**
   * saving to share preferences
   */

  static Future<bool> writeTokne(value) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setString(_Token, value);
  }

  static Future<bool> writeTheme(value) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setBool(_theme, value);
  }

  // getting data
  static Future<bool> getTheme() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.getBool(_theme)!;
  }

  static Future<bool> saveUserLoggInState(bool isLoggedIn) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setBool(_userLogingKey, isLoggedIn);
  }

  static Future<bool> saveUserName(String userName) async {
  print("PREFERCE USER NAME IS $userName");
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setString(_userNameKey, userName);
  }


  static Future<bool> saveUserProfile(String profile) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setString(_userProfile, profile);
  }

  static Future<bool> saveUserTel(String tel) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setString(_userTelKey, tel);
  }

  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setString(_userEmailKey, userEmail);
  }

  static Future<bool> saveUserID(String id) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setString(_userIDKey, id);
  }



  static Future<bool> saveUserNumberOfGroups(String number) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setString(_userNumberOfGroups, number);
  }

    static Future<bool> saveUserNumberOfChats(String number) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.setString(_userChats, number);
  }

  // getting data

  static Future<String> getUserToken() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.getString(_Token)!;
  }

  static Future<String> getUserEmail() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.getString(_userEmailKey)!;
  }

   static Future<String> getUserTel() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return await sharedPreference.getString(_userTelKey)!;
  }


  static Future<String> getUserName() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return  sharedPreference.getString(_userNameKey)!;
  }


    static Future<String> getUserProfile() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return  sharedPreference.getString(_profilePic)!;
  }

   static Future<String> getUserNumberOfGroups() async{
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return  sharedPreference.getString(_userNumberOfGroups)!;
  }

     static Future<String> getUserNumberOfChats() async{
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return  sharedPreference.getString(_userChats)!;
  }

  static Future<String> getUserID() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return  sharedPreference.getString(_userIDKey)!;
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
