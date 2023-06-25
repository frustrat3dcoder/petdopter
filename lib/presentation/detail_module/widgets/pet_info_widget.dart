import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';
import 'package:petdopter/presentation/detail_module/widgets/custom_info_tile.dart';
import 'package:petdopter/utils/utils.dart';

class PetInfoWidget extends StatelessWidget {
  const PetInfoWidget(
      {super.key, required this.animalEntity, required this.themeNotifier});

  final AnimalEntity animalEntity;
  final ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTileInfo(
                value: animalEntity.sex!,
                title: 'Sex',
                backgroundColor: secondaryTeal,
                assetName: ''),
            CustomTileInfo(
                value: animalEntity.age.toString(),
                title: 'Age',
                backgroundColor: secondaryOrange,
                assetName: ''),
            CustomTileInfo(
                value: animalEntity.weight!,
                title: 'Weight',
                backgroundColor: kButtonBlue,
                assetName: '')
          ],
        ),
        20.h,
        Text("Bio",
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: customTextStyle(
              colors: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
              fontWeight: FontWeight.w600,
              fontSize: 24.0,
            )),
        10.h,
        Text(animalEntity.bio!,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: customTextStyle(
              colors: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            )),
        30.h,
        Text("Specialities",
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: customTextStyle(
              colors: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
              fontWeight: FontWeight.w600,
              fontSize: 24.0,
            )),
        10.h,
        Wrap(
          children: animalEntity.traits
              .map((e) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    margin: const EdgeInsets.only(right: 5, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: themeNotifier.isDarkMode
                            ? kWhiteColor
                            : textDarkColor),
                    child: Text(e.capitalizeFirst.toString(),
                        style: customTextStyle(
                          colors: themeNotifier.isDarkMode
                              ? textDarkColor
                              : kWhiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        )),
                  ))
              .toList(),
        )
      ],
    );
  }

  Widget buildCustomInfoTile(
      {required String value,
      required String title,
      required Color backgroundColor,
      required String assetName}) {
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
