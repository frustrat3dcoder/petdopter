part of 'search_animal_bloc.dart';

abstract class SearchAnimalState extends Equatable {
  const SearchAnimalState();
  
  @override
  List<Object> get props => [];
}

class SearchAnimalInitial extends SearchAnimalState {}
