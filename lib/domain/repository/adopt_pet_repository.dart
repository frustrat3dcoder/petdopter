import 'package:petdopter/domain/entities/animal_entity.dart';

abstract class AdoptRepository {
  Future<bool> adoptPet(
      {required String documentId, required Map<String, dynamic> updateValue});

  Future<AnimalEntityList> getAdoptedPetData({required String userId});
}
