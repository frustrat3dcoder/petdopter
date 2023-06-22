import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/presentation/dashboard_module/widgets/home_wrapper.dart';
import 'package:petdopter/presentation/dashboard_module/widgets/profile_wrapper.dart';
import 'package:petdopter/presentation/dashboard_module/widgets/search_wrapper.dart';
import 'package:petdopter/utils/utils.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  List<Widget> pages = [
    HomeScreenWrapper(),
    SearchScreenWrapper(),
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
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10.0,
            sigmaY: 10.0,
          ),
          child: BottomNavigationBar(
            backgroundColor: themeNotifier.isDarkMode
                ? kAppBarBgColor.withOpacity(0.30)
                : kWhiteColor.withOpacity(0.60),
            showSelectedLabels: false,
            elevation: 5,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: kWhiteColor,
            unselectedItemColor: charcolColor_60,
            selectedIconTheme: IconThemeData(size: 20, color: kWhiteColor),
            unselectedIconTheme:
                IconThemeData(size: 16, color: kWhiteColor.withOpacity(0.6)),
            currentIndex: _currentIndex,
            iconSize: 30,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.bottomNavItem1,
                  color: _currentIndex == 0
                      ? Colors.white
                      : kWhiteColor.withOpacity(0.5),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.bottomNavItem2,
                  color: _currentIndex == 1
                      ? Colors.white
                      : kWhiteColor.withOpacity(0.5),
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.bottomNavItem3,
                  color: _currentIndex == 2
                      ? Colors.white
                      : kWhiteColor.withOpacity(0.5),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
