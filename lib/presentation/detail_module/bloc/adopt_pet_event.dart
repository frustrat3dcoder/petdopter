part of 'adopt_pet_bloc.dart';

abstract class AdoptPetEvent extends Equatable {
  const AdoptPetEvent();

  @override
  List<Object> get props => [];
}

class UserAdoptPetEvent extends AdoptPetEvent {
  const UserAdoptPetEvent({required this.animalEntity});

  final AnimalEntity animalEntity;

  @override
  List<Object> get props => [animalEntity];
}

class AddPetToUsersRecordEvent extends AdoptPetEvent {
  const AddPetToUsersRecordEvent(
      {required this.animalEntity, required this.userId});
  final AnimalEntity animalEntity;
  final String userId;

  @override
  List<Object> get props => [animalEntity, userId];
}
