import 'package:petdopter/domain/entities/animal_entity.dart';

abstract class AdoptUseCase {
  Future<bool> adoptPet();

  Future<AnimalEntityList> getAdoptedPetData();
}

class AdoptPetUseCase extends AdoptUseCase {
  @override
  Future<bool> adoptPet() async {
    return true;
  }

  @override
  Future<AnimalEntityList> getAdoptedPetData() {
    throw (Error());
  }
}
