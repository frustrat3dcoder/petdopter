import 'package:flutter/material.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/utils/utils.dart';

Widget themeSwitcherButton(ThemeNotifier themeNotifier) {
  return GestureDetector(
      onTap: () {
        toggleTheme(themeNotifier);
      },
      child: Container(
          // width: 70,
          // height: 30,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(25),
          //   color: themeNotifier.isDarkMode ? textDarkColor : primaryYellow,
          // ),
          child: Stack(
        alignment: themeNotifier.isDarkMode
            ? Alignment.centerRight
            : Alignment.centerLeft,
        children: [
          // const Positioned(
          //   left: 10,
          //   child: Icon(
          //     Icons.sunny,
          //     color: primaryYellow,
          //     size: 20,
          //   ),
          // ),
          // const Positioned(
          //   right: 10,
          //   child: Icon(
          //     Icons.nightlight,
          //     color: textDarkColor,
          //     size: 20,
          //   ),
          // ),
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
      )));

  // return Switch(
  //   value: themeNotifier.isDarkMode,
  //   inactiveThumbColor:
  //       themeNotifier.isDarkMode ? textDarkColor : primaryYellow,
  //   activeColor: themeNotifier.isDarkMode ? primaryYellow : textDarkColor,
  //   activeTrackColor: themeNotifier.isDarkMode ? textDarkColor : primaryYellow,
  //   inactiveTrackColor: themeNotifier.isDarkMode ? primaryYellow : Colors.grey,
  //   onChanged: (value) {
  //     toggleTheme(themeNotifier, value);
  //   },
  // );
}

void toggleTheme(ThemeNotifier themeNotifier) {
  themeNotifier.changeThemeMode(!themeNotifier.isDarkMode);
}
