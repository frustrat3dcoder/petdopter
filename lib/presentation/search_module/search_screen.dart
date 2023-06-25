import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';
import 'package:petdopter/domain/entities/user_entity.dart';
import 'package:petdopter/presentation/home_module/bloc/animal_data_bloc.dart';
import 'package:petdopter/presentation/home_module/widgets/list_grid.dart';
import 'package:petdopter/utils/utils.dart';
import 'package:provider/provider.dart';

class SearchScreenWrapper extends StatelessWidget {
  const SearchScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnimalDataBloc(fetchPetListUseCase: di()),
      child: SearchScreen(
        argument: Get.arguments,
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.argument});

  final Map<String, dynamic> argument;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late AnimalDataBloc _animalBloc;

  bool isLoading = false;

  String leftHandFilter = "name";
  dynamic rightHandFilter = '';
  bool isSetStateCalledforState = false;

  late UserEntity userEntity;

  @override
  void initState() {
    super.initState();
    userEntity = widget.argument["userEntity"];
    _animalBloc = BlocProvider.of<AnimalDataBloc>(context);
  }

  Future<void> _updateStream() async {
    setState(() {
      isSetStateCalledforState = false;
      _animalBloc.add(FetchDataByFilters(
          leftComparator: leftHandFilter,
          rightComparator: rightHandFilter,
          limit: 0));
      isLoading = false;
    });
  }

  TextEditingController nameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: themeNotifier.isDarkMode ? textDarkColor : kWhiteColor,
      // appBar: AppBar(
      //   shadowColor: Colors.transparent,
      //   backgroundColor: Colors.transparent,
      //   foregroundColor: Colors.transparent,
      //   toolbarHeight: 60,
      //   // leading: ,
      //   title: ,
      // ),
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Column(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                // margin: const EdgeInsets.only(left: 10.0),
                height: 80,
                child: TextFormField(
                  validator: (val) {
                    if (val != null) {
                      return null;
                    } else {
                      return "Please enter wake up time";
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameEditingController,
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none),
                      fillColor: themeNotifier.isDarkMode
                          ? textDarkColor
                          : Colors.grey,
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                          )),
                      isDense: true,
                      contentPadding: EdgeInsets.all(15),
                      errorStyle: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(
                              color: themeNotifier.isDarkMode
                                  ? kWhiteColor
                                  : textDarkColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                      hintText: 'Search by name',
                      prefixIcon: InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: themeNotifier.isDarkMode
                                  ? kWhiteColor
                                  : textDarkColor,
                              borderRadius: BorderRadius.circular(14.0)),
                          child: SvgPicture.asset(
                            AppAssets.customBackArrow,
                            color: themeNotifier.isDarkMode
                                ? textDarkColor
                                : kWhiteColor,
                          ),
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _animalBloc.add(FetchDataByFilters(
                              leftComparator: leftHandFilter,
                              rightComparator:
                                  nameEditingController.text.toLowerCase(),
                              limit: 0,
                            ));
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: themeNotifier.isDarkMode
                                  ? kWhiteColor
                                  : textDarkColor,
                              borderRadius: BorderRadius.circular(14.0)),
                          child: SvgPicture.asset(
                            AppAssets.searchIcon,
                            color: themeNotifier.isDarkMode
                                ? textDarkColor
                                : kWhiteColor,
                          ),
                        ),
                      )),
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
