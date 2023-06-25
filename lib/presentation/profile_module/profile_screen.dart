import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petdopter/common_widgets/custom_buttons.dart';
import 'package:petdopter/common_widgets/theme_switcher.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/user_entity.dart';
import 'package:petdopter/presentation/landing_module/bloc/auth_bloc.dart';
import 'package:petdopter/utils/utils.dart';
import 'package:provider/provider.dart';

class ProfileScreenWrapper extends StatelessWidget {
  const ProfileScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final HiveService hiveService = di<HiveService>();
  late UserEntity userEntity;

  @override
  void initState() {
    initDataFromLocal();
    super.initState();
  }

  void initDataFromLocal() async {
    final userMap = hiveService.retrieveValue('userEntity');

    setState(() {
      userEntity = UserEntity.fromJson(jsonDecode(userMap));
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: Container(
          color: themeNotifier.isDarkMode ? textDarkColor : kWhiteColor,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              50.h,
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(color: kWhiteColor)),
                      width: double.infinity,
                      height: 180,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                              'https://steamuserimages-a.akamaihd.net/ugc/937215911992753009/B3CCF0C4675B864CEA6901B46FCFA40A5A9A98FD/',
                              fit: BoxFit.fitWidth))),
                  Positioned(
                    bottom: -60,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(userEntity.profileImage),
                        ),
                      ),
                      width: 140,
                      height: 140,
                    ),
                  )
                ],
              ),
              100.h,
              Container(
                decoration: BoxDecoration(
                    color: themeNotifier.isDarkMode
                        ? textDarkColorComplement
                        : Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(22.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTile("Name", userEntity.name, themeNotifier),
                    customDivider(themeNotifier),
                    buildTile("Email", userEntity.email, themeNotifier),
                    customDivider(themeNotifier),
                    buildSwitcher('DarkMode', themeNotifier)
                  ],
                ),
              ),
              const Spacer(),
              buildLogoutButton(themeNotifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget customDivider(ThemeNotifier themeNotifier) {
    return Consumer(
        builder: (context, value, child) => Divider(
              color: themeNotifier.isDarkMode ? Colors.grey : kWhiteColor,
              thickness: 2,
            ));
  }

  Widget buildTile(String label, String title, ThemeNotifier themeNotifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor),
          ),
          5.h,
          Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
                fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget buildSwitcher(String buttonTitle, ThemeNotifier themeNotifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            buttonTitle,
            maxLines: 2,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor),
          ),
          5.h,
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: themeSwitcherButton(themeNotifier),
          ),
        ],
      ),
    );
  }

  Widget buildLogoutButton(ThemeNotifier themeNotifier) {
    return customLargeButton(
        onTap: () =>
            BlocProvider.of<AuthBloc>(context).add(LoggedOutUserEvent()),
        marginVertical: 10.0,
        marginHorizontal: 15.0,
        text: 'Logout',
        width: 230,
        textColor: !themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
        fontWeight: FontWeight.w500,
        textSize: 18.0,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 6), // Horizontal and vertical offset
            blurRadius: 4, // Spread radius
            spreadRadius: 2, // Extend the shadow
          ),
        ],
        buttonType: CustomButtonType.text,
        gradientColor: themeNotifier.isDarkMode
            ? [kWhiteColor, kWhiteColor]
            : [textDarkColor, textDarkColor]);
  }
}
