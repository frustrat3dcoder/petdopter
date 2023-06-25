import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petdopter/domain/domain.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';

part 'adopt_pet_event.dart';
part 'adopt_pet_state.dart';

class AdoptPetBloc extends Bloc<AdoptPetEvent, AdoptPetState> {
  final AdoptPetUseCase adoptPetUseCase;
  AdoptPetBloc({required this.adoptPetUseCase}) : super(AdoptPetInitial()) {
    on<UserAdoptPetEvent>((event, emit) async {
      final result = await adoptPetUseCase.adoptPet(
          documentId: event.documentId, updateValue: event.updateValue);

      if (result) {
        emit(AdoptPetSuccess(adoptStatus: result));
        add(GetUsersPetRecordEvent(userId: event.userId));
      } else {
        emit(const AdoptPetError(message: "Something went wrong"));
        add(UserAdoptPetEvent(
            animalEntity: event.animalEntity,
            userId: event.userId,
            documentId: event.documentId,
            updateValue: const {"status": 0}));
      }
    });

    on<GetUsersPetRecordEvent>((event, emit) async {
      final result =
          await adoptPetUseCase.getAdoptedPetData(userId: event.userId);

      emit(GetUsersPetData(animalEntityList: result));
    });
  }
}
