import 'package:get_it/get_it.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/domain.dart';

final di = GetIt.instance;

void setupLocator() async {
  di.registerLazySingleton<HiveService>(() => HiveService());
  di.registerFactory<UserAuthUseCase>(() => UserAuthUseCase(
        repositroy: di(),
      ));

  di.registerFactory<AuthRepositroy>(() => AuthRepositroyImpl());
}
