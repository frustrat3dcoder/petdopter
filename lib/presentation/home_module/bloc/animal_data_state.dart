part of 'animal_data_bloc.dart';

abstract class AnimalDataState extends Equatable {
  const AnimalDataState();

  @override
  List<Object> get props => [];
}

class AnimalDataInitial extends AnimalDataState {}

class AnimalDataLoaded extends AnimalDataState {
  AnimalDataLoaded();

// StreamSink<AnimalEntityList> streamSink = _streamController.sink;
}

class FailedToLoadData extends AnimalDataState {}
