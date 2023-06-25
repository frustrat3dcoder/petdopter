import 'package:petdopter/domain/entities/animal_entity.dart';

abstract class AdoptRepository {
  Future<bool> adoptPet();

  Future<AnimalEntityList> getAdoptedPetData();
}
