import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdopter/data/data.dart';

import '../../../domain/entities/animal_entity.dart';
import 'animal_info_tile.dart';
import 'configurations.dart';

class BuildAsperSnapShot extends StatelessWidget {
  const BuildAsperSnapShot(
      {super.key, required this.snapshot, required this.themeNotifier});

  final AsyncSnapshot<AnimalEntityList> snapshot;
  final ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    return buildWidgetAsPerStatus(snapshot, themeNotifier);
  }

  Widget buildWidgetAsPerStatus(
      AsyncSnapshot<AnimalEntityList> snapshot, ThemeNotifier themeNotifier) {
    if (snapshot.hasData) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.0,
          mainAxisExtent: 250,
        ),
        itemCount: snapshot.data!.entities.length,
        itemBuilder: (BuildContext context, int index) {
          final randomIndex = Random().nextInt(imagePaths.length);

          var document = snapshot.data!.entities[index];

          return Hero(
            tag: document.id!,
            child: InkWell(
              onTap: () => Get.toNamed(Routes.detailScreen, arguments: {
                "animalEntity": document,
                "backgroundAsset": imagePaths[randomIndex].keys.first,
                "backgroundColor": imagePaths[randomIndex].values.first,
              }),
              child: AnimalInfoTile(
                animalEntity: document,
                assetName: imagePaths[randomIndex].keys.first,
                color: imagePaths[randomIndex].values.first,
                themeNotifier: themeNotifier,
              ),
            ),
          );
        },
      );
    } else if (snapshot.hasError) {
      return const Text(
        "Something went wrong!",
        style: TextStyle(color: Colors.white),
      );
    }
    return const SizedBox();
  }
}
