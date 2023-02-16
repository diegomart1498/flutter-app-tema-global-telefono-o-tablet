import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  bool _darkTheme = false;
  bool _customTheme = false;
  ThemeData _currentTheme = ThemeData.light();
  final temaPersonalizado = ThemeData.dark().copyWith(
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff48A0EB)),
    appBarTheme: const AppBarTheme(color: Color(0xff48A0EB)),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: const Color(0xff16202B),
  );

  ThemeChanger(int theme) {
    switch (theme) {
      case 1: //light
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light();
        break;
      case 2: //dark
        _darkTheme = true;
        _customTheme = false;
        _currentTheme = ThemeData.dark();
        break;
      case 3: //custom
        _darkTheme = false;
        _customTheme = true;
        _currentTheme = temaPersonalizado;
        break;
      default:
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light();
    }
  }

  bool get darkTheme => _darkTheme;
  set darkTheme(bool valor) {
    _customTheme = false;
    _darkTheme = valor;
    if (valor) {
      _currentTheme = ThemeData.dark();
    } else {
      _currentTheme = ThemeData.light();
    }
    notifyListeners();
  }

  bool get customTheme => _customTheme;
  set customTheme(bool valor) {
    _darkTheme = false;
    _customTheme = valor;
    if (valor) {
      _currentTheme = temaPersonalizado;
    } else {
      _currentTheme = ThemeData.light();
    }
    notifyListeners();
  }

  ThemeData get currentTheme => _currentTheme;
}
