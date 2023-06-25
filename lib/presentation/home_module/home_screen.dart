import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:petdopter/common_widgets/custom_buttons.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/domain.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';
import 'package:petdopter/domain/entities/user_entity.dart';
import 'package:petdopter/presentation/home_module/bloc/animal_data_bloc.dart';
import 'package:petdopter/presentation/home_module/widgets/list_grid.dart';
import 'package:petdopter/utils/utils.dart';
import 'package:provider/provider.dart';

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AnimalDataBloc(fetchPetListUseCase: di<GetPetListUseCase>()),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  int limit = 10;

  bool isLoading = false;
  late UserEntity userEntity;
  final HiveService hiveService = di<HiveService>();

  ScrollController scrollController = ScrollController();
  double scrollOffset = 0.0;

  String leftHandFilter = "recommended";
  dynamic rightHandFilter = true;

  late AnimalDataBloc _animalBloc;
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    initDataFromLocal();
    super.initState();
    scrollController.addListener(_scrollListener);
    _animalBloc = BlocProvider.of<AnimalDataBloc>(context);
    _animalBloc.add(FetchDataByFilters(
        leftComparator: leftHandFilter,
        rightComparator: rightHandFilter,
        limit: limit));
  }

  void initDataFromLocal() async {
    final userMap = hiveService.retrieveValue('userEntity');

    setState(() {
      userEntity = UserEntity.fromJson(jsonDecode(userMap));
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);

    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
          scrollOffset = scrollController.offset;
          limit += 10;
        });
        _updateStream(); // Increase limit to fetch more documents
      }
    }
  }

  Future<void> _updateStream() async {
    setState(() {
      isSetStateCalledforState = false;
      _animalBloc.add(FetchDataByFilters(
          leftComparator: leftHandFilter,
          rightComparator: rightHandFilter,
          limit: limit));
      isLoading = false;
    });
  }

  changeFilter({required String left, required dynamic right}) {
    setState(() {
      leftHandFilter = left;
      rightHandFilter = right;
      limit = 10;
    });
    _updateStream();
  }

  @override
  bool get wantKeepAlive => true;
  bool isSetStateCalledforState = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollOffset);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    super.build(context);

    return Scaffold(
      key: scaffoldMessengerKey,
      backgroundColor: themeNotifier.isDarkMode ? textDarkColor : kWhiteColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: customAppBar(themeNotifier)),
      body: SafeArea(
        child: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                petFilterButtons(themeNotifier),
                20.h,
                if (leftHandFilter == 'recommended')
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      leftHandFilter.capitalizeFirst.toString(),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: themeNotifier.isDarkMode
                              ? kWhiteColor
                              : textDarkColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0),
                    ),
                  ),
                if (leftHandFilter == 'recommended') 20.h,
                StreamBuilder<AnimalEntityList>(
                    stream: _animalBloc.streamController.stream,
                    builder: (context, snapshot) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        if (mounted && isSetStateCalledforState == false) {
                          setState(() {
                            isSetStateCalledforState = true;
                          });
                        }
                      });
                      return BuildAsperSnapShot(
                        snapshot: snapshot,
                        themeNotifier: themeNotifier,
                        userEntity: userEntity,
                      );
                    }),
                Visibility(
                  visible: isLoading == true,
                  replacement: const SizedBox.shrink(),
                  child: const SizedBox(
                    height: 50,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.red,
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget petFilterButtons(ThemeNotifier themeNotifier) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          commonSvgButton(
              callback: () => changeFilter(left: 'recommended', right: true),
              assetName: AppAssets.petBorderSvg,
              height: 80,
              width: 80,
              marginHorizontal: 5.0,
              marginVertical: 5.0,
              themeNotifier: themeNotifier),
          commonSvgButton(
              callback: () => changeFilter(left: 'type', right: "Dog"),
              assetName: AppAssets.dogSvg,
              height: 80,
              width: 80,
              marginHorizontal: 5.0,
              marginVertical: 5.0,
              themeNotifier: themeNotifier),
          commonSvgButton(
              callback: () => changeFilter(left: "type", right: "Cat"),
              assetName: AppAssets.catSvg,
              height: 80,
              width: 80,
              marginHorizontal: 5.0,
              marginVertical: 5.0,
              themeNotifier: themeNotifier),
          commonSvgButton(
              callback: () => changeFilter(left: "type", right: "Bird"),
              assetName: AppAssets.parrotSvg,
              height: 80,
              width: 80,
              marginHorizontal: 5.0,
              marginVertical: 5.0,
              themeNotifier: themeNotifier),
        ],
      ),
    );
  }

  Widget customAppBar(ThemeNotifier themeNotifier) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 250,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Center(
          child: Text(
            userEntity.name,
            maxLines: 1,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: !themeNotifier.isDarkMode ? textDarkColor : kWhiteColor,
                fontSize: 22.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      toolbarHeight: 60,
      actions: [
        commonSvgButton(
            callback: () {},
            assetName: AppAssets.bellSvg,
            width: 50,
            height: 50,
            themeNotifier: themeNotifier),
        commonSvgButton(
            callback: () {},
            assetName: AppAssets.heartFilledSvg,
            width: 50,
            height: 50,
            themeNotifier: themeNotifier),
      ],
    );
  }

  commonSvgButton(
      {required Function() callback,
      required String assetName,
      required double width,
      required double height,
      required ThemeNotifier themeNotifier,
      double marginVertical = 5.0,
      double marginHorizontal = 5.0}) {
    return customLargeButton(
      marginVertical: marginVertical,
      marginHorizontal: marginHorizontal,
      text: '',
      onTap: callback,
      icon: assetName,
      buttonType: CustomButtonType.onlyIcon,
      width: width,
      height: height,
      gradientColor: themeNotifier.isDarkMode
          ? [kWhiteColor, kWhiteColor]
          : [Colors.grey.withOpacity(0.5), Colors.grey.withOpacity(0.5)],
      paddingHorizontal: 5,
      paddingVertical: 5,
      iconColor: textDarkColor,
    );
  }
}
