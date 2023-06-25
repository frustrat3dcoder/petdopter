import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_animal_event.dart';
part 'search_animal_state.dart';

class SearchAnimalBloc extends Bloc<SearchAnimalEvent, SearchAnimalState> {
  SearchAnimalBloc() : super(SearchAnimalInitial()) {
    on<SearchAnimalEvent>((event, emit) {});
  }
}
