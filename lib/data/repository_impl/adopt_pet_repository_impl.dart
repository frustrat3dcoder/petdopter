import 'package:petdopter/domain/domain.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';

class AdoptPetRepositoryImpl extends AdoptRepository {
  @override
  Future<bool> adoptPet() {
    throw UnimplementedError();
  }

  @override
  Future<AnimalEntityList> getAdoptedPetData() {
    throw UnimplementedError();
  }
}
