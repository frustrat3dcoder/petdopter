part of 'adoption_history_bloc.dart';

abstract class AdoptionHistoryState extends Equatable {
  const AdoptionHistoryState();
  
  @override
  List<Object> get props => [];
}

class AdoptionHistoryInitial extends AdoptionHistoryState {}
