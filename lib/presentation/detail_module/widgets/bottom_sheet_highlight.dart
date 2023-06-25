import 'package:flutter/material.dart';
import 'package:petdopter/data/services/services.dart';
import 'package:petdopter/utils/utils.dart';

class bottomSheetCustomHighlighter extends StatelessWidget {
  const bottomSheetCustomHighlighter({
    super.key,
    required this.themeNotifier,
  });

  final ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 10,
        width: 40,
        decoration: BoxDecoration(
            color: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
