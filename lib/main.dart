import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdopter/presentation/landing_module/landing_page.dart';
import 'package:petdopter/presentation/splash_module/splash_page.dart';
import 'package:petdopter/utils/app_static_values/app_static_values.dart';
import 'package:petdopter/utils/size_config.dart';
import 'package:provider/provider.dart';

import 'config/config.dart';
import 'data/data.dart';

Future<void> initializeDependency() async {
  // firebase initialize the config
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //dependency injector initialize
  setupLocator();

  //hive service init opens the box
  await di<HiveService>().init(AppStrings.hiveBoxName);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependency();
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(darkTheme),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    SizeConfig().init(context);
    return GetMaterialApp(
      title: 'Petdopter',
      theme: themeNotifier.getTheme(),
      initialRoute: Routes.splashScreen,
      debugShowCheckedModeBanner: false,
      getPages: Pages.pages,
      builder: (context, child) => child!,
    );
  }
}
