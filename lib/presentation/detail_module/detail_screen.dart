import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petdopter/common_widgets/custom_buttons.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';
import 'package:petdopter/presentation/detail_module/bloc/adopt_pet_bloc.dart';
import 'package:petdopter/presentation/detail_module/widgets/image_widget.dart';
import 'package:petdopter/presentation/home_module/bloc/animal_data_bloc.dart';
import 'package:petdopter/utils/utils.dart';
import 'package:provider/provider.dart';

import 'widgets/pet_info_class.dart';
import 'package:confetti/confetti.dart';

class DetailScreenWrapper extends StatelessWidget {
  const DetailScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AnimalDataBloc(fetchPetListUseCase: di())),
        BlocProvider(create: (context) => AdoptPetBloc(adoptPetUseCase: di())),
      ],
      child: DetailScreen(arguments: Get.arguments),
    );
  }
}

class DetailScreen extends StatefulWidget {
  DetailScreen({super.key, required this.arguments});
  final dynamic arguments;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late AnimalEntity animalEntity;

  late String backgroundAsset;

  late Color backgroundColor;

  late String userId;
  late ConfettiController _controllerCenter;

  bool isBlocALoaded = false;
  bool isBlocBLoaded = false;
  String buttonTitle = "Adopt Me";

  @override
  void initState() {
    animalEntity = widget.arguments["animalEntity"];
    backgroundAsset = widget.arguments["backgroundAsset"];
    backgroundColor = widget.arguments["backgroundColor"];
    userId = widget.arguments["userId"];
    BlocProvider.of<AnimalDataBloc>(context).add(FetchDataByFilters(
        leftComparator: 'id', rightComparator: animalEntity.id, limit: 1));

    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 3));
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

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
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          if (isBlocALoaded == false) {
                            print(
                                "userId is  ${state.animalEntityList.entities.first.ownerId == userId}");
                            setState(() {
                              buttonTitle = state.animalEntityList.entities
                                          .first.status ==
                                      0
                                  ? 'Adopt Me'
                                  : state.animalEntityList.entities.first
                                              .ownerId
                                              .toString() ==
                                          userId
                                      ? 'You\'ve now adopted ${animalEntity.name}'
                                      : 'Already Adopted';
                              isBlocALoaded = true;
                              if (state.animalEntityList.entities.first.ownerId
                                          .toString() ==
                                      userId &&
                                  isBlocBLoaded == true) {
                                showLoader();
                              }
                            });
                          }
                        });

                        return customLargeButton(
                            marginVertical: 20.0,
                            marginHorizontal: 20.0,
                            text: buttonTitle,
                            fontWeight: FontWeight.w600,
                            gradientColor: themeNotifier.isDarkMode
                                ? [kWhiteColor, kWhiteColor]
                                : [textDarkColor, textDarkColor],
                            onTap: () {
                              isBlocALoaded = false;
                              if (adoptStatus == 0) {
                                setState(() {
                                  isBlocBLoaded = true;
                                });
                                BlocProvider.of<AdoptPetBloc>(context)
                                    .add(UserAdoptPetEvent(
                                        animalEntity: animalEntity,
                                        documentId: animalEntity.id!,
                                        updateValue: {
                                          "status": 1,
                                          "owner_id": userId,
                                        },
                                        userId: userId));

                                BlocProvider.of<AnimalDataBloc>(context).add(
                                    FetchDataByFilters(
                                        leftComparator: 'id',
                                        rightComparator: animalEntity.id,
                                        limit: 1));
                              }
                            });
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

  void showLoader() async {
    Get.dialog(
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 10, sigmaY: 10, tileMode: TileMode.mirror),
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                    true, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually
                child: SizedBox.shrink(),
              ),
            ),
          ],
        ),
        barrierDismissible: false,
        useSafeArea: true,
        barrierColor: Colors.black.withOpacity(0.8));
    _controllerCenter.play();

    await Future.delayed(const Duration(seconds: 2), () => Get.back());
  }
}
