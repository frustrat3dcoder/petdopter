import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/user_entity.dart';
import 'package:petdopter/presentation/dashboard_module/dashboard_page.dart';
import 'package:petdopter/presentation/landing_module/landing_page.dart';
import 'package:petdopter/utils/app_static_values/app_color_pallete.dart';
import 'package:petdopter/utils/extensions/extensions.dart';
import 'package:petdopter/utils/size_config.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
  final HiveService hiveService = di<HiveService>();

  // void initState() {
  //   // checkAuthSession();
  //   super.initState();
  // }

  checkAuthSession(BuildContext buildContext) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await hiveService.retrieveValue('userEntity');
      // if (result != null) {

      Navigator.pushReplacement(
          buildContext,
          MaterialPageRoute(
              builder: (buildContext) =>
                  result == null ? LandingPageWrapper() : Dashboard()));
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkAuthSession(context);
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        color: const Color(0xff3BA4B3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.network(
              'https://assets6.lottiefiles.com/packages/lf20_zvcsnqgi.json',
            ),
            Text(
              'Petdopter',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: kWhiteColor,
                    fontSize: 44.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            10.h,
            Text(
              'Search - Visit - Adopt',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: kWhiteColor,
                    fontSize: 16.0,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
