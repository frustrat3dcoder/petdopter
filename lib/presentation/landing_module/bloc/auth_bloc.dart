import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdopter/core/core.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/domain.dart';
import 'package:petdopter/domain/entities/user_entity.dart';
import 'package:petdopter/utils/app_static_values/app_static_values.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserAuthUseCase _authUseCase = di<UserAuthUseCase>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthenticateUserEvent>((event, emit) async {
      //emitting loading state
      emit(AuthLoading());
      //extends the use case and call the function
      final result = await _authUseCase.authenticateWithGoogle();

      // after result pass on the value as per state using fold
      result.fold(
        (authEntity) {
          emit(AuthLoaded(userEntity: authEntity));
          di<HiveService>().storeValue('userEntity', jsonEncode(authEntity));
          Get.offAllNamed(Routes.dashboardScreen);
        },
        (failure) => emit(AuthError(failure: failure)),
      );
    });

    on<LoggedOutUserEvent>((event, emit) async {
      //emitting loading state
      emit(AuthLoading());
      //extends the use case and call the function
      final result = await _authUseCase.authenticateWithGoogle();

      // after result pass on the value as per state using fold
      result.fold(
        (authEntity) {
          emit(LoggedOut());
          di<HiveService>().deleteValue('userEntity');
          Get.offAllNamed(Routes.landingScreen);
        },
        (failure) => emit(AuthError(failure: failure)),
      );
    });
  }
}
