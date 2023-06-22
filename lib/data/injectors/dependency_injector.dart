import 'package:get_it/get_it.dart';
import 'package:petdopter/data/data.dart';

final di = GetIt.instance;

void setupLocator() async {
  di.registerLazySingleton<HiveService>(() => HiveService());
}
