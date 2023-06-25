import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petdopter/utils/utils.dart';

class CustomTileInfo extends StatelessWidget {
  const CustomTileInfo(
      {super.key,
      required this.value,
      required this.title,
      required this.backgroundColor,
      required this.assetName});

  final String value;
  final String title;
  final Color backgroundColor;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(25.0)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            height: 70,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppAssets.paw_group,
                fit: BoxFit.contain,
                color: backgroundColor,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value,
                  style: customTextStyle(
                    colors: textDarkColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                  )),
              5.h,
              Text(title,
                  style: customTextStyle(
                      colors: textDarkColor.withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0))
            ],
          ),
        ],
      ),
    );
  }
}
