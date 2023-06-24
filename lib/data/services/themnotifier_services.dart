import 'package:flutter/material.dart';
import 'package:petdopter/data/injectors/dependency_injector.dart';
import 'package:petdopter/utils/utils.dart';

import 'hive_service.dart';

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
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
      .copyWith(
        background: kAppBarBgColor,
        brightness: Brightness.dark,
      )
      .copyWith(background: kAppBarBgColor),
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
    )
        .copyWith(background: const Color(0xFFE5E5E5))
        .copyWith(background: kWhiteColor));

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;
  HiveService hiveService = di<HiveService>();

  ThemeNotifier(this._themeData) {
    setMode();
  }

  getTheme() => _themeData;

  changeThemeMode(bool mode) async {
    isDarkMode = mode;
    hiveService.storeValue('isDarkMode', mode);
    _themeData = isDarkMode ? darkTheme : lightTheme;
    notifyListeners();
  }

  bool isDarkMode = true;

  setMode() {
    bool value = hiveService.retrieveValue('isDarkMode') ?? true;
    isDarkMode = value;
    notifyListeners();
  }
}
