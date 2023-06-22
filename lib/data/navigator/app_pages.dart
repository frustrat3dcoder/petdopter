import 'package:get/get.dart';
import 'package:petdopter/presentation/presentation.dart';

part 'app_routes.dart';

class Pages {
  static List<GetPage> pages = [
    GetPage(
      name: Routes.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.landingScreen,
      page: () => const LandingPageWrapper(),
    ),
    GetPage(
        name: Routes.dashboardScreen,
        page: () => const Dashboard(),
        maintainState: true),
  ];
}
