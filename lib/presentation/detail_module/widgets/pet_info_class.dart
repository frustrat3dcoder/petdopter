import 'package:flutter/material.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';
import 'package:petdopter/presentation/detail_module/widgets/bottom_sheet_highlight.dart';
import 'package:petdopter/presentation/detail_module/widgets/pet_info_header.dart';
import 'package:petdopter/utils/utils.dart';

import 'pet_info_widget.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    super.key,
    required this.themeNotifier,
    required this.animalEntity,
  });

  final ThemeNotifier themeNotifier;
  final AnimalEntity animalEntity;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: SizeConfig.screenHeight * 0.61,
        decoration: BoxDecoration(
          color: themeNotifier.isDarkMode ? textDarkColor : kWhiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.h,
              bottomSheetCustomHighlighter(themeNotifier: themeNotifier),
              10.h,
              // Name and Description
              PetInfoHeader(
                  animalEntity: animalEntity, themeNotifier: themeNotifier),

              30.h,

              // Age, Weight and Sex, Bio and Speciality
              PetInfoWidget(
                  animalEntity: animalEntity, themeNotifier: themeNotifier),

              80.h,
            ],
          ),
        ),
      ),
    );
  }
}
