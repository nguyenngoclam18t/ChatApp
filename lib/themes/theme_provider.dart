import 'package:chat_app/themes/dark_mode.dart';
import 'package:chat_app/themes/light_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightmode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData value) {
    _themeData = value;
    notifyListeners();
  }

  bool isDarkMode() => _themeData == darkmode;
  void toggleTheme() {
    if (_themeData == darkmode) {
      themeData = lightmode;
    } else {
      themeData = darkmode;
    }
  }
}
