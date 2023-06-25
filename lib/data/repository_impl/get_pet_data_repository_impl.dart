import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petdopter/domain/domain.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';

class FetchPetDataRepositoryImpl extends FetchAnimalDataRepository {
  FetchPetDataRepositoryImpl();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<List<AnimalEntity>> getPetData(
      {required String leftComprator,
      required dynamic rightComparatorValue,
      required int limit}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> result = await _firestore
          .collection('pet_data')
          .limit(limit)
          .where(leftComprator, isEqualTo: rightComparatorValue)
          .get();
      final List<AnimalEntity> animalEntity = [];
      result.docs.forEach((element) {
        animalEntity.add(AnimalEntity.fromJson(element.data()));
      });

      return animalEntity;
    } catch (e) {
      rethrow;
    }
  }
}
