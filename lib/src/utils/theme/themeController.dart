import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:njadia/src/common/helper_function.dart';
import 'package:njadia/src/utils/theme/themes.dart';

class ThemeController extends GetxController {
  // final _box =HelperFunction();
  // final _key = "isDarkMode";

  //  late bool currentTheme;

  // // Get the theme mode from local storage

  // ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;
  // bool _loadTheme() => currentTheme??false;

  // // void savetheme (bool isDarkMode) =_box.writeTheme(_key,"isDarkMode");
  // void changeTheme(ThemeData theme)=>Get.changeTheme(theme);
  // void changeThemeMode(ThemeMode themeMode)=>Get.changeThemeMode(themeMode);

  var _theme = AppTheme.lightTheme.obs;
  var currentTheme = false.obs;

  ThemeData get theme =>
      currentTheme.value ? AppTheme.lightTheme : AppTheme.darkTheme;

  // void changeTheme() => currentTheme.value = !currentTheme.value;

  var isDark = false;
  changeTheme(state) {
    if (state == true) {
      state = true;
      Get.changeTheme(AppTheme.darkTheme);
    } else {
      state = false;
      Get.changeTheme(AppTheme.lightTheme);
    }
    update();
  }
}
