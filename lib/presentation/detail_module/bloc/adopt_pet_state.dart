part of 'adopt_pet_bloc.dart';

abstract class AdoptPetState extends Equatable {
  const AdoptPetState();

  @override
  List<Object> get props => [];
}

class AdoptPetInitial extends AdoptPetState {}

class AdoptPetSuccess extends AdoptPetState {
  const AdoptPetSuccess({required this.adoptStatus});
  final bool adoptStatus;

  @override
  List<Object> get props => [];
}

class AdoptPetError extends AdoptPetState {
  const AdoptPetError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class AddPetToUserSuccess extends AdoptPetState {
  const AddPetToUserSuccess({required this.adoptStatus});
  final bool adoptStatus;

  @override
  List<Object> get props => [];
}

class AddAdoptedPetToUserError extends AdoptPetState {}
