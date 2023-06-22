import 'package:flutter/material.dart';
import 'package:petdopter/domain/domain.dart';
import 'package:petdopter/utils/utils.dart';

class PageSlides extends StatelessWidget {
  const PageSlides({super.key, required this.sliderEntity});

  final SliderEntity sliderEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          20.h,
          buildBannerImage(),
          50.h,
          bannerTitle(context),
        ],
      ),
    );
  }

  RichText bannerTitle(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: sliderEntity.preHighlightText ?? '',
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: 36.0,
              fontWeight: FontWeight.w900,
              color: textDarkColor,
            ),
        children: [
          TextSpan(
            text: sliderEntity.highlightText ?? '',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w900,
                  color: kButtonBlue,
                ),
            children: [
              TextSpan(
                text: sliderEntity.postHighlightText ?? '',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w900,
                      color: textDarkColor,
                    ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildBannerImage() {
    return Image.asset(
      sliderEntity.imageUrl!,
      fit: BoxFit.contain,
      height: 250,
      width: 250,
      alignment: Alignment.bottomCenter,
    );
  }
}
