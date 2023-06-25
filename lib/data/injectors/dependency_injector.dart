import 'package:get_it/get_it.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/domain.dart';
import 'package:petdopter/presentation/detail_module/bloc/adopt_pet_bloc.dart';

final di = GetIt.instance;

void setupLocator() async {
  di.registerLazySingleton<HiveService>(() => HiveService());
  di.registerFactory<UserAuthUseCase>(() => UserAuthUseCase(
        repositroy: di(),
      ));

  di.registerFactory<AuthRepositroy>(() => AuthRepositroyImpl());
  di.registerFactory<AdoptRepository>(() => AdoptPetRepositoryImpl());
  di.registerFactory<FetchAnimalDataRepository>(
      () => FetchPetDataRepositoryImpl());

  di.registerFactory<GetPetListUseCase>(() => GetPetListUseCase(
        fetchAnimalDataRepository: di(),
      ));

  di.registerFactory<AdoptPetUseCase>(() => AdoptPetUseCase(
        adoptRepository: di(),
      ));

  di.registerSingleton<AdoptPetBloc>(AdoptPetBloc(adoptPetUseCase: di()));
}
