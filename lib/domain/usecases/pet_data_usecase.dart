import 'package:petdopter/domain/domain.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';

abstract class FetchPetListUseCase {
  Future<List<AnimalEntity>> getPetData(
      {required String leftComprator,
      required dynamic rightComparatorValue,
      required int limit});
}

class GetPetListUseCase extends FetchPetListUseCase {
  GetPetListUseCase(
      {required FetchAnimalDataRepository fetchAnimalDataRepository})
      : _fetchAnimalDataRepository = fetchAnimalDataRepository;

  final FetchAnimalDataRepository _fetchAnimalDataRepository;

  @override
  Future<List<AnimalEntity>> getPetData(
      {required String leftComprator,
      required dynamic rightComparatorValue,
      required int limit}) async {
    final result = await _fetchAnimalDataRepository.getPetData(
        leftComprator: leftComprator,
        rightComparatorValue: rightComparatorValue,
        limit: limit);

    return result;
  }
}
