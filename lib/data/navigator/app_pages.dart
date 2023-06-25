import 'package:get/get.dart';
import 'package:petdopter/presentation/detail_module/detail_screen.dart';
import 'package:petdopter/presentation/detail_module/widgets/photo_preview.dart';
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
    GetPage(
      name: Routes.searchScreen,
      page: () => const SearchScreenWrapper(),
    ),
    GetPage(
      name: Routes.detailScreen,
      page: () => DetailScreenWrapper(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: Routes.imagePreview,
      page: () => PetImageViewer(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
