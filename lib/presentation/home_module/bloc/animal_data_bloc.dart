import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:petdopter/domain/domain.dart';
import 'package:petdopter/domain/entities/animal_entity.dart';

part 'animal_data_event.dart';
part 'animal_data_state.dart';

class AnimalDataBloc extends Bloc<AnimalDataEvent, AnimalDataState> {
  final GetPetListUseCase fetchPetListUseCase;
  final StreamController<AnimalEntityList> streamController =
      StreamController<AnimalEntityList>();

  StreamSink<AnimalEntityList>? _streamSink;

  AnimalDataBloc({required this.fetchPetListUseCase})
      : super(AnimalDataInitial()) {
    _streamSink = streamController.sink;
    on<FetchDataByFilters>((event, emit) async {
      emit(AnimalDataInitial());
      final animalEntity = await fetchPetListUseCase.getPetData(
          leftComprator: event.leftComparator,
          rightComparatorValue: event.rightComparator,
          limit: event.limit);

      emit(AnimalDataLoaded(
          animalEntityList: AnimalEntityList(entities: animalEntity)));

      _streamSink!.add(AnimalEntityList(entities: animalEntity));
    });

    on<AdoptAnimal>((event, emit) {
      // extend the use case

      // wait for data

      //emit state
    });
  }

  AnimalEntityList transformSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    final animalEntityList = AnimalEntityList.fromSnapshot(
        snapshot.docs.map((doc) => doc.data()).toList());

    return animalEntityList;
  }
}
