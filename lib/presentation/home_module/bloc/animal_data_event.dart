part of 'animal_data_bloc.dart';

abstract class AnimalDataEvent extends Equatable {
  const AnimalDataEvent();

  @override
  List<Object> get props => [];
}

class FetchDataByFilters extends AnimalDataEvent {
  FetchDataByFilters(
      {required this.leftComparator,
      required this.rightComparator,
      required this.limit});

  final String leftComparator;
  final dynamic rightComparator;
  final int limit;

  @override
  List<Object> get props => [];
}

class AdoptAnimal extends AnimalDataEvent {}
