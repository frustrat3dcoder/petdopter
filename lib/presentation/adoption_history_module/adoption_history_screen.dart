import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';
import 'package:petdopter/domain/entities/user_entity.dart';
import 'package:petdopter/presentation/detail_module/bloc/adopt_pet_bloc.dart';
import 'package:petdopter/presentation/home_module/widgets/animal_info_tile.dart';
import 'package:petdopter/presentation/home_module/widgets/configurations.dart';
import 'package:petdopter/utils/utils.dart';
import 'package:provider/provider.dart';

class AdoptionHistoryScreenWrapper extends StatelessWidget {
  const AdoptionHistoryScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<AdoptPetBloc>(),
      child: const AdoptionHistoryScreen(),
    );
  }
}

class AdoptionHistoryScreen extends StatefulWidget {
  const AdoptionHistoryScreen({super.key});

  @override
  State<AdoptionHistoryScreen> createState() => _AdoptionHistoryScreenState();
}

class _AdoptionHistoryScreenState extends State<AdoptionHistoryScreen> {
  final HiveService hiveService = di();
  late UserEntity userEntity;

  @override
  void initState() {
    super.initState();
    initDataFromLocal();
  }

  void initDataFromLocal() async {
    final userMap = hiveService.retrieveValue('userEntity');

    setState(() {
      userEntity = UserEntity.fromJson(jsonDecode(userMap));
    });

    BlocProvider.of<AdoptPetBloc>(context)
        .add(GetUsersPetRecordEvent(userId: userEntity.id));
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: themeNotifier.isDarkMode ? textDarkColor : kWhiteColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 5,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Pet Record",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
              fontSize: 44.0),
        ),
      ),
      body: SafeArea(
        child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: BlocBuilder<AdoptPetBloc, AdoptPetState>(
              builder: (context, state) {
                print("Get Object data is ${state.runtimeType}");
                if (state is GetUsersPetData) {
                  print(
                      "Get Object data is ${state.animalEntityList.entities.length}");
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                      mainAxisExtent: 250,
                    ),
                    itemCount: state.animalEntityList.entities.length,
                    itemBuilder: (context, index) {
                      final randomIndex = Random().nextInt(imagePaths.length);

                      final entity = state.animalEntityList.entities[index];
                      return Hero(
                        tag: entity.name!,
                        child: InkWell(
                          onTap: () =>
                              Get.toNamed(Routes.detailScreen, arguments: {
                            "animalEntity": entity,
                            "backgroundAsset":
                                imagePaths[randomIndex].keys.first,
                            "backgroundColor":
                                imagePaths[randomIndex].values.first,
                            "userId": userEntity.id,
                            "from": "adoption-page"
                          }),
                          child: AnimalInfoTile(
                              animalEntity: entity,
                              assetName: imagePaths[randomIndex].keys.first,
                              color: imagePaths[randomIndex].values.first,
                              themeNotifier: themeNotifier),
                        ),
                      );
                    },
                  );
                }
                return NoPetDataFound(themeNotifier: themeNotifier);
              },
            )),
      ),
    );
  }

  Widget buildListTile(
      {required AnimalEntity entity, required ThemeNotifier themeNotifier}) {
    return Text(
      entity.name!,
      maxLines: 2,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
          color: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
          fontSize: 44.0),
    );

    // return Container(child: Image.network(entity.imageUrl!),)
  }
}

class NoPetDataFound extends StatelessWidget {
  const NoPetDataFound({
    super.key,
    required this.themeNotifier,
  });

  final ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(AppAssets.noPetData, fit: BoxFit.fitWidth),
      Text(
        "You've not adopted any pet yet",
        maxLines: 2,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
            fontSize: 44.0),
      )
    ]);
  }
}
