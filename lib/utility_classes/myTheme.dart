
import 'package:flutter/material.dart';

import 'package:driver_bits/config.dart';

class MyTheme with ChangeNotifier {
  static bool _isDark = false;

  MyTheme() {
    if (hive.containsKey('darktheme')) {
      _isDark = hive.get('darktheme');
    } else {
      hive.put('darktheme', _isDark);
    }
  }

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme(bool nextValue) {
    _isDark = nextValue;
    hive.put('darktheme', _isDark);
    notifyListeners();
  }

  bool get isItDark => _isDark;
}