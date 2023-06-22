import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petdopter/utils/utils.dart';

Widget customLargeButton({
  required double marginVertical,
  required double marginHorizontal,
  double? width,
  double? height,
  double? textSize,
  Color? textColor,
  FontWeight? fontWeight,
  double? paddingVertical,
  double? paddingHorizontal,
  required String text,
  required VoidCallback onTap,
  List<Color>? gradientColor,
  String? icon,
  List<BoxShadow>? boxShadow,
  CustomButtonType buttonType = CustomButtonType.text,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width ?? SizeConfig.screenWidth,
      height: height ?? 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.70),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColor ?? blueGradient,
        ),
        boxShadow: boxShadow,
      ),
      margin: EdgeInsets.symmetric(
        vertical: marginVertical,
        horizontal: marginHorizontal,
      ),
      padding: EdgeInsets.symmetric(
        vertical: paddingVertical ?? 10.0,
        horizontal: paddingHorizontal ?? 10.0,
      ),
      child: buildButtonAsPerType(
        buttonType: buttonType,
        icon: icon,
        text: text,
        textColor: textColor,
        fontWeight: fontWeight,
      ),
    ),
  );
}

buildButtonAsPerType(
    {required CustomButtonType buttonType,
    String? icon,
    textSize,
    Color? textColor,
    FontWeight? fontWeight,
    String? text}) {
  if (buttonType == CustomButtonType.onlyIcon) {
    return Center(
        child: SvgPicture.asset(
      icon ?? AppAssets.defaultPetIcon,
      alignment: Alignment.center,
    ));
  } else if (buttonType == CustomButtonType.textWithPrefixIcon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          icon ?? AppAssets.defaultPetIcon,
          alignment: Alignment.center,
          width: 30,
        ),
        10.w,
        Text(
          text!,
          style: TextStyle(
              fontSize: textSize ?? 16.0,
              color: textColor ?? Colors.black,
              fontWeight: fontWeight ?? FontWeight.w400),
        )
      ],
    );
  } else if (buttonType == CustomButtonType.textWithSuffixIcon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text!,
          style: TextStyle(
              fontSize: textSize ?? 16.0,
              color: textColor ?? Colors.black,
              fontWeight: fontWeight ?? FontWeight.w400),
        ),
        10.w,
        Image.asset(
          icon ?? AppAssets.defaultPetIcon,
          alignment: Alignment.center,
          width: 30,
        ),
      ],
    );
  } else {
    return Center(
      child: Text(
        text!,
        style: TextStyle(
            fontSize: textSize ?? 16.0,
            color: textColor ?? Colors.black,
            fontWeight: fontWeight ?? FontWeight.w400),
      ),
    );
  }
}
