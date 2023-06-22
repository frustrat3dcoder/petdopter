import 'package:flutter/material.dart';
import 'package:petdopter/utils/utils.dart';

final darkTheme = ThemeData(
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  hintColor: Colors.white, scaffoldBackgroundColor: Colors.black,
  // accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  fontFamily: 'Gilroy',
  textTheme: TextTheme(
    displayLarge: customTextStyle(
      colors: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24.0,
    ),
    displayMedium: customTextStyle(
      colors: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    displaySmall: customTextStyle(
      colors: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
    ),
    titleLarge: customTextStyle(
      colors: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
    ),
    titleSmall: customTextStyle(
      colors: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
    background: Colors.black,
    brightness: Brightness.dark,
  ),
);

final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    hintColor: Colors.black,
    // accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    fontFamily: 'Gilroy',
    textTheme: TextTheme(
      displayLarge: customTextStyle(
        colors: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
      displayMedium: customTextStyle(
        colors: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
      displaySmall: customTextStyle(
        colors: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      ),
      titleLarge: customTextStyle(
        colors: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      ),
      titleSmall: customTextStyle(
        colors: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
      brightness: Brightness.light,
    ).copyWith(background: const Color(0xFFE5E5E5)));

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  bool isDarkMode = true;
}
