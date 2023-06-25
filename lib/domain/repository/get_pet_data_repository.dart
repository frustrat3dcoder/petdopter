import 'package:petdopter/domain/entities/animal_entity.dart';

abstract class FetchAnimalDataRepository {
  Future<List<AnimalEntity>> getPetData(
      {required String leftComprator,
      required dynamic rightComparatorValue,
      required int limit});
}
