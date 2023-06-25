import 'package:flutter/material.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';
import 'package:petdopter/utils/utils.dart';

class AnimalInfoTile extends StatelessWidget {
  const AnimalInfoTile(
      {super.key,
      required this.animalEntity,
      required this.assetName,
      required this.color,
      required this.themeNotifier});

  final AnimalEntity animalEntity;
  final ThemeNotifier themeNotifier;
  final String assetName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return animalInfoTile(
        animalEntity, themeNotifier, assetName, color, context);
  }

  Widget animalInfoTile(AnimalEntity document, ThemeNotifier themeNotifier,
      String assetName, Color color, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 160,
              height: 250,
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: color,
                  image: DecorationImage(
                      image: AssetImage(assetName),
                      colorFilter: ColorFilter.mode(
                          document.status == 0
                              ? color
                              : Colors.black.withOpacity(0.8),
                          BlendMode.srcATop),
                      alignment: Alignment.bottomLeft),
                  borderRadius: BorderRadius.circular(25.0)),
            ),
            Positioned(
                top: 30,
                left: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.name!,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: textDarkColor,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Age: ${document.age!} years",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: textDarkColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
            Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                child: Image.network(
                  document.imageUrl!,
                  width: 120,
                  height: 180,
                  fit: BoxFit.contain,
                ))
          ],
        ),
      ],
    );
  }
}
