import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  // Define a propriedade como um observable
  var isDark = false.obs;

  Map<String, ThemeMode> themeModes = {
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
  };

  late SharedPreferences prefs;

  // Recupera a instância da classe
  static ThemeController get to => Get.find();

  void loadThemeMode() async {
    prefs = await SharedPreferences.getInstance();
    String themeText = prefs.getString('theme') ?? 'light';

    isDark.value = themeText == 'dark' ? true : false;
    setMode(themeText);
  }

  Future setMode(String themeText) async {
    ThemeMode themeMode = themeModes[themeText]!;
    Get.changeThemeMode(themeMode);

    prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', themeText);
  }

  changeTheme() {
    setMode(isDark.value ? 'light' : 'dark');
    isDark.value = !isDark.value;
  }
}
