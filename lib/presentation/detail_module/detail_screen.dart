import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';
import 'package:petdopter/presentation/home_module/bloc/animal_data_bloc.dart';
import 'package:petdopter/presentation/landing_module/bloc/auth_bloc.dart';
import 'package:petdopter/utils/utils.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Hero(
          tag: animalEntity.id!,
          flightShuttleBuilder: (flightContext, animation, flightDirection,
              fromHeroContext, toHeroContext) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return toHeroContext.widget;
              case HeroFlightDirection.pop:
                return fromHeroContext.widget;
            }
          },
          child: Material(
            color: Colors.transparent,
            child: Center(
                child: InkWell(
                    onTap: () => Get.toNamed(Routes.imagePreview,
                        arguments: animalEntity.id!),
                    child: Image.network(animalEntity.imageUrl!))),
          )),
    );
  }
}
