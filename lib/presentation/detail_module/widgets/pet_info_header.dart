import 'package:flutter/material.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';
import 'package:petdopter/utils/utils.dart';

class PetInfoHeader extends StatelessWidget {
  const PetInfoHeader({
    super.key,
    required this.animalEntity,
    required this.themeNotifier,
  });

  final AnimalEntity animalEntity;
  final ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              animalEntity.name!,
              style: customTextStyle(
                  colors:
                      themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 31.0),
            ),
          ],
        ),
        5.h,
        Text(
          "Bread : ${animalEntity.breed!}",
          style: customTextStyle(
              colors: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
              fontWeight: FontWeight.w500,
              fontSize: 16.0),
        ),
      ],
    );
  }
}
