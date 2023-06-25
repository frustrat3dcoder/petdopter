import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';

part 'adopt_pet_event.dart';
part 'adopt_pet_state.dart';

class AdoptPetBloc extends Bloc<AdoptPetEvent, AdoptPetState> {
  // final
  AdoptPetBloc() : super(AdoptPetInitial()) {
    on<UserAdoptPetEvent>((event, emit) {});
    on<AddPetToUsersRecordEvent>((event, emit) {});
  }
}
