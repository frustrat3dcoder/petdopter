part of 'adopt_pet_bloc.dart';

abstract class AdoptPetEvent extends Equatable {
  const AdoptPetEvent();

  @override
  List<Object> get props => [];
}

class UserAdoptPetEvent extends AdoptPetEvent {
  const UserAdoptPetEvent(
      {required this.animalEntity,
      required this.userId,
      required this.documentId,
      required this.updateValue});

  final AnimalEntity animalEntity;
  final String userId;
  final String documentId;
  final Map<String, dynamic> updateValue;

  @override
  List<Object> get props => [animalEntity, userId, documentId, updateValue];
}

class GetUsersPetRecordEvent extends AdoptPetEvent {
  const GetUsersPetRecordEvent({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];
}
