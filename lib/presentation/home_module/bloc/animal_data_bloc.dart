import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'animal_data_event.dart';
part 'animal_data_state.dart';

class AnimalDataBloc extends Bloc<AnimalDataEvent, AnimalDataState> {
  AnimalDataBloc() : super(AnimalDataInitial()) {
    on<AnimalDataEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
