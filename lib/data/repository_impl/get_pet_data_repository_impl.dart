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
      late QuerySnapshot<Map<String, dynamic>> result;
      Query<Map<String, dynamic>> temp =
          _firestore.collection('pet_data').limit(limit);
      if (leftComprator != '') {
        result = await temp
            .where(leftComprator, isEqualTo: rightComparatorValue)
            .get();
      } else {
        result = await temp.get();
      }

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
