import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petdopter/domain/domain.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';

class AdoptPetRepositoryImpl extends AdoptRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> adoptPet(
      {required String documentId,
      required Map<String, dynamic> updateValue}) async {
    try {
      await _firestore
          .collection('pet_data')
          .doc(documentId)
          .update(updateValue);

      return true;
    } catch (err) {
      return false;
    }
  }

  @override
  Future<AnimalEntityList> getAdoptedPetData({required String userId}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> result = await _firestore
          .collection('pet_data')
          .where('ownerId', isEqualTo: userId)
          .get();
      final List<AnimalEntity> animalEntity = [];
      result.docs.forEach((element) {
        animalEntity.add(AnimalEntity.fromJson(element.data()));
      });

      return AnimalEntityList(entities: animalEntity);
    } catch (e) {
      rethrow;
    }
  }
}
