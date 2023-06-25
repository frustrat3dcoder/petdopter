import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/user_entity.dart';
import 'package:petdopter/presentation/detail_module/bloc/adopt_pet_bloc.dart';
import 'package:petdopter/presentation/presentation.dart';
import 'package:petdopter/utils/utils.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  List<Widget> pages = const [
    HomeScreenWrapper(),
    AdoptionHistoryScreenWrapper(),
    ProfileScreenWrapper()
  ];
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeNotifier.isDarkMode ? textDarkColor : kWhiteColor,
        showSelectedLabels: false,
        elevation: 5,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kWhiteColor,
        unselectedItemColor: charcolColor_60,
        // selectedIconTheme: const IconThemeData(size: 20, color: kWhiteColor),
        // unselectedIconTheme:
        //     IconThemeData(size: 16, color: kWhiteColor.withOpacity(0.6)),
        currentIndex: _currentIndex,
        iconSize: 30,
        onTap: (int index) {
          if (index == 1) {
            initDataFromLocal();
          }
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.bottomNavItem1,
              color: getColorbyIndex(0, themeNotifier),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.bottomNavItem2,
              color: getColorbyIndex(1, themeNotifier),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.bottomNavItem3,
              color: getColorbyIndex(2, themeNotifier),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  getColorbyIndex(int i, ThemeNotifier themeNotifier) {
    if (themeNotifier.isDarkMode) {
      return _currentIndex == i ? Colors.white : Colors.white.withOpacity(0.8);
    } else {
      return _currentIndex == i ? Colors.black : Colors.black.withOpacity(0.8);
    }
  }

  void initDataFromLocal() async {}
}
