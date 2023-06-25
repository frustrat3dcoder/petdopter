// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:petdopter/data/repository_impl/adopt_pet_repository_impl.dart';
// import 'package:petdopter/domain/entities/animal_entity.dart';

// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// class MockCollectionReference extends Mock implements CollectionReference {}

// class MockDocumentReference extends Mock implements DocumentReference {}

// class MockQuerySnapshot extends Mock implements QuerySnapshot {}

// void main() {
//   late MockFirebaseFirestore mockFirestore;
//   late MockCollectionReference mockCollectionRef;
//   late MockDocumentReference mockDocumentRef;
//   late MockQuerySnapshot mockQuerySnapshot;
//   late AdoptPetRepositoryImpl repository;

//   setUp(() {
//     mockFirestore = MockFirebaseFirestore();
//     mockCollectionRef = MockCollectionReference();
//     mockDocumentRef = MockDocumentReference();
//     mockQuerySnapshot = MockQuerySnapshot();
//     repository = AdoptPetRepositoryImpl();
//   });

//   group('Adopt Pet Repository', () {
//     test('should update pet data when adopting', () async {
//       // Arrange
//       final documentId = 'documentId';
//       final updateValue = {'name': 'Max', 'age': 2};
//       when(mockFirestore.collection('pet_data')).thenReturn(mockCollectionRef);
//       when(mockCollectionRef.doc(documentId)).thenReturn(mockDocumentRef);

//       // Act
//       final result = await repository.adoptPet(
//         documentId: documentId,
//         updateValue: updateValue,
//       );

//       // Assert
//       expect(result, isTrue);
//       verify(mockFirestore.collection('pet_data')).called(1);
//       verify(mockCollectionRef.doc(documentId)).called(1);
//       verify(mockDocumentRef.update(updateValue)).called(1);
//       verifyNoMoreInteractions(mockFirestore);
//       verifyNoMoreInteractions(mockCollectionRef);
//       verifyNoMoreInteractions(mockDocumentRef);
//     });

//     test('should return adopted pet data for a specific user', () async {
//       // Arrange
//       final userId = 'userId';
//       final animalData = [
//         {'name': 'Max', 'age': 2},
//         {'name': 'Bella', 'age': 3},
//       ];
//       final expectedEntityList = AnimalEntityList(
//         entities: animalData.map((data) => AnimalEntity.fromJson(data)).toList(),
//       );

//       when(mockFirestore.collection('pet_data')).thenReturn(mockCollectionRef);
//       when(mockCollectionRef.where('owner_id', isEqualTo: userId))
//           .thenReturn(mockCollectionRef);
//       when(mockCollectionRef.get()).thenAnswer((_) async => mockQuerySnapshot);
//       when(mockQuerySnapshot.docs)
//           .thenReturn(animalData.map((data) => MockDocumentSnapshot(data)).toList());

//       // Act
//       final result = await repository.getAdoptedPetData(userId: userId);

//       // Assert
//       expect(result, equals(expectedEntityList));
//       verify(mockFirestore.collection('pet_data')).called(1);
//       verify(mockCollectionRef.where('owner_id', isEqualTo: userId)).called(1);
//       verify(mockCollectionRef.get()).called(1);
//       verifyNoMoreInteractions(mockFirestore);
//       verifyNoMoreInteractions(mockCollectionRef);
//       verifyNoMoreInteractions(mockQuerySnapshot);
//     });
//   });
// }

// class MockDocumentSnapshot extends Mock implements DocumentSnapshot {
//   final Map<String, dynamic> data;

//   MockDocumentSnapshot(this.data);

//   @override
//   Map<String, dynamic> get data => this.data;
// }
