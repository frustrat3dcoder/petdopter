import 'package:flutter/material.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/utils/utils.dart';

Widget themeSwitcherButton(ThemeNotifier themeNotifier) {
  return GestureDetector(
      onTap: () {
        toggleTheme(themeNotifier);
      },
      child: Stack(
        alignment: themeNotifier.isDarkMode
            ? Alignment.centerRight
            : Alignment.centerLeft,
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: themeNotifier.isDarkMode
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              width: 30,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeNotifier.isDarkMode ? textDarkColor : primaryYellow,
              ),
              child: Icon(
                themeNotifier.isDarkMode ? Icons.nightlight : Icons.sunny,
                color: themeNotifier.isDarkMode ? primaryYellow : textDarkColor,
                size: 20,
              ),
            ),
          ),
        ],
      ));
}

void toggleTheme(ThemeNotifier themeNotifier) {
  themeNotifier.changeThemeMode(!themeNotifier.isDarkMode);
}
