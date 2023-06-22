import 'package:flutter/material.dart';

TextStyle customTextStyle({
  required colors,
  required fontWeight,
  required fontSize,
  double? letterHeight,
  double? letterSpacing,
  TextDecoration? decoration,
}) {
  return TextStyle(
    color: colors,
    fontWeight: fontWeight,
    fontSize: fontSize,
    decoration: decoration ?? TextDecoration.none,
    fontFamily: 'Gilroy',
    height: letterHeight ?? 1.0,
    letterSpacing: letterSpacing ?? 1.0,
  );
}
