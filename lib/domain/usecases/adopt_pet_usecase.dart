import 'package:petdopter/domain/domain.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';

abstract class AdoptUseCase {
  Future<bool> adoptPet(
      {required String documentId, required Map<String, dynamic> updateValue});

  Future<AnimalEntityList> getAdoptedPetData({required String userId});
}

class AdoptPetUseCase extends AdoptUseCase {
  final AdoptRepository _adoptRepository;

  AdoptPetUseCase({required AdoptRepository adoptRepository})
      : _adoptRepository = adoptRepository;

  @override
  Future<bool> adoptPet(
      {required String documentId,
      required Map<String, dynamic> updateValue}) async {
    final result = await _adoptRepository.adoptPet(
        documentId: documentId, updateValue: updateValue);

    return result;
  }

  @override
  Future<AnimalEntityList> getAdoptedPetData({required String userId}) async {
    final result = await _adoptRepository.getAdoptedPetData(userId: userId);

    return result;
  }
}
