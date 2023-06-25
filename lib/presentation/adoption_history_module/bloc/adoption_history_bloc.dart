import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'adoption_history_event.dart';
part 'adoption_history_state.dart';

class AdoptionHistoryBloc
    extends Bloc<AdoptionHistoryEvent, AdoptionHistoryState> {
  AdoptionHistoryBloc() : super(AdoptionHistoryInitial()) {
    on<AdoptionHistoryEvent>((event, emit) {});
  }
}
