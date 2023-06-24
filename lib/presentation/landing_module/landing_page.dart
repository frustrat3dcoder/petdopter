import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petdopter/common_widgets/theme_switcher.dart';
import 'package:petdopter/common_widgets/widgets.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/domain.dart';
import 'package:petdopter/presentation/landing_module/bloc/auth_bloc.dart';
import 'package:petdopter/utils/utils.dart';
import 'package:provider/provider.dart';

class LandingPageWrapper extends StatelessWidget {
  const LandingPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    initTimer();
  }

  initTimer() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (_currentPage != pages.length - 1) {
          setState(() {
            _currentPage += 1;
          });
        } else {
          setState(() {
            _currentPage = 0;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  //

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: Container(
          color: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Stack(
            children: [
              Column(
                children: [
                  20.h,
                  bannerPageView(),
                  const Spacer(),
                  bannerDescription(context),
                  10.h,
                  buildContinueButton(themeNotifier),
                  dotIndicatorWidget(themeNotifier)
                ],
              ),
              Positioned(right: 0, child: themeSwitcherButton(themeNotifier))
            ],
          ),
        ),
      ),
    );
  }

  Widget dotIndicatorWidget(ThemeNotifier themeNotifier) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(pages.length, (int index) {
          return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 10,
              width: (index == _currentPage) ? 30 : 10,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: (index == _currentPage)
                      ? themeNotifier.isDarkMode
                          ? primaryYellow
                          : textDarkColorComplement
                      : themeNotifier.isDarkMode
                          ? textDarkColorComplement
                          : primaryYellow));
        }));
  }

  SizedBox bannerPageView() {
    return SizedBox(
      height: 400,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
              bottom: 0,
              top: 0,
              right: 0,
              left: 0,
              child: Image.asset(AppAssets.orangeBanner)),
          PageView.builder(
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            controller: _pageController,
            clipBehavior: Clip.none,
            itemCount: pages.length,
            itemBuilder: (context, index) => pages[_currentPage],
          ),
        ],
      ),
    );
  }

  Widget buildContinueButton(ThemeNotifier themeNotifier) {
    return customLargeButton(
        onTap: () =>
            BlocProvider.of<AuthBloc>(context).add(AuthenticateUserEvent()),
        marginVertical: 10.0,
        marginHorizontal: 15.0,
        text: 'Get Started',
        width: 230,
        textColor: themeNotifier.isDarkMode ? kWhiteColor : textDarkColor,
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
        buttonType: CustomButtonType.textWithPrefixIcon,
        icon: AppAssets.gmailLogo);
  }

  SizedBox bannerDescription(BuildContext context) {
    return SizedBox(
      width: 225,
      child: Text(
        'Join us and discover the best pet in your location',
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(color: textlightColor),
        // textAlign: TextAlign.center,
      ),
    );
  }
}

List<Widget> pages = [
  const PageSlides(
    sliderEntity: SliderEntity(
      highlightText: 'Dream ',
      imageUrl: AppAssets.landingBanner1,
      postHighlightText: 'Pet Here',
      preHighlightText: 'Find Your ',
    ),
  ),
  const PageSlides(
    sliderEntity: SliderEntity(
      highlightText: 'Your Company ',
      imageUrl: AppAssets.landingBanner2,
      postHighlightText: '',
      preHighlightText: 'They Need ',
    ),
  ),
  const PageSlides(
    sliderEntity: SliderEntity(
      highlightText: 'Cute ',
      imageUrl: AppAssets.landingBanner3,
      postHighlightText: 'Pet',
      preHighlightText: 'Good Environment ',
    ),
  ),
  const PageSlides(
    sliderEntity: SliderEntity(
      highlightText: 'Time ',
      imageUrl: AppAssets.landingBanner4,
      postHighlightText: 'Be Happy',
      preHighlightText: 'Spend Quality ',
    ),
  ),
];
