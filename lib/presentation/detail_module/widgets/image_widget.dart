import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petdopter/data/navigator/navigation.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';
import 'package:petdopter/utils/utils.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.backgroundColor,
    required this.animalEntity,
    this.from,
  });

  final Color backgroundColor;
  final AnimalEntity animalEntity;
  final String? from;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.4,
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.4),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                AppAssets.paw_group,
                fit: BoxFit.contain,
                color: backgroundColor,
              ),
            ),
          ),
          Hero(
            tag: from != null ? animalEntity.name! : animalEntity.id!,
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
                      arguments: animalEntity.imageUrl!),
                  child: Image.network(
                    animalEntity.imageUrl!,
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
