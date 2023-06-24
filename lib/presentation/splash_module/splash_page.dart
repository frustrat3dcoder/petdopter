import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/utils/app_static_values/app_color_pallete.dart';
import 'package:petdopter/utils/extensions/extensions.dart';
import 'package:petdopter/utils/size_config.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final HiveService hiveService = di<HiveService>();

  checkAuthSession(BuildContext buildContext) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await hiveService.retrieveValue('userEntity');

      Get.offNamed(
          result != null ? Routes.dashboardScreen : Routes.landingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    checkAuthSession(context);
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        color: themeNotifier.isDarkMode ? textDarkColor : kWhiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.network(
              'https://assets6.lottiefiles.com/packages/lf20_zvcsnqgi.json',
            ),
            Text(
              'Petdopter',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color:
                        themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
                    fontSize: 44.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            10.h,
            Text(
              'Search - Visit - Adopt',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color:
                        themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
                    fontSize: 16.0,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
