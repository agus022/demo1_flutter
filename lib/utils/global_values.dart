import 'package:demo1/utils/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalValues {
 static ValueNotifier isValidating = ValueNotifier(false);
 static ValueNotifier themeApp = ValueNotifier(ThemeData.light());
 static ValueNotifier updList = ValueNotifier(false);
 

  static Future<void> changeTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);

    if (theme == 'light') {
      themeApp.value = ThemeSettings.lightTheme();
    } else if (theme == 'dark') {
      themeApp.value = ThemeSettings.darkTheme();
    } else if (theme == 'game'){
      themeApp.value = ThemeSettings.gameTheme();
    }
  }

  static Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString('theme') ?? 'light';
    await changeTheme(savedTheme);
  }

}