import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petdopter/common_widgets/custom_buttons.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';
import 'package:petdopter/presentation/detail_module/widgets/image_widget.dart';
import 'package:petdopter/presentation/home_module/bloc/animal_data_bloc.dart';
import 'package:petdopter/utils/utils.dart';
import 'package:provider/provider.dart';

import 'widgets/pet_info_class.dart';

class DetailScreenWrapper extends StatelessWidget {
  DetailScreenWrapper({super.key});
  late AnimalEntity animalEntity;

  @override
  Widget build(BuildContext context) {
    ;
    return BlocProvider(
      create: (context) => AnimalDataBloc(fetchPetListUseCase: di()),
      child: DetailScreen(arguments: Get.arguments),
    );
  }
}

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key, required this.arguments});
  final dynamic arguments;
  late AnimalEntity animalEntity;
  late String backgroundAsset;
  late Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    animalEntity = arguments["animalEntity"];
    backgroundAsset = arguments["backgroundAsset"];
    backgroundColor = arguments["backgroundColor"];
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    BlocProvider.of<AnimalDataBloc>(context).add(FetchDataByFilters(
        leftComparator: 'id', rightComparator: animalEntity.id, limit: 1));

    return Scaffold(
      backgroundColor: themeNotifier.isDarkMode ? textDarkColor : kWhiteColor,
      body: SafeArea(
        child: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ImageWidget(
                  backgroundColor: backgroundColor, animalEntity: animalEntity),
              InfoContainer(
                  themeNotifier: themeNotifier, animalEntity: animalEntity),
              backButton(themeNotifier),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<AnimalDataBloc, AnimalDataState>(
                    builder: (context, state) {
                      if (state is AnimalDataLoaded) {
                        final int adoptStatus =
                            state.animalEntityList.entities.first.status!;

                        return customLargeButton(
                            marginVertical: 20.0,
                            marginHorizontal: 20.0,
                            text: adoptStatus == 0
                                ? "Adopt Me"
                                : "Already Adopted",
                            fontWeight: FontWeight.w600,
                            gradientColor: themeNotifier.isDarkMode
                                ? [kWhiteColor, kWhiteColor]
                                : [textDarkColor, textDarkColor],
                            onTap: () {});
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Positioned backButton(ThemeNotifier themeNotifier) {
    return Positioned(
      top: 20,
      left: 10,
      child: InkWell(
        onTap: () => Get.back(),
        child: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
              borderRadius: BorderRadius.circular(14.0)),
          child: SvgPicture.asset(
            AppAssets.customBackArrow,
            color: themeNotifier.isDarkMode ? textDarkColor : kWhiteColor,
          ),
        ),
      ),
    );
  }
}
