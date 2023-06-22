part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {}

class AuthInitial extends AuthState {}

class AuthLoaded extends AuthState {
  final UserEntity userEntity;

  const AuthLoaded({required this.userEntity});
}

class AuthError extends AuthState {
  final Failure failure;

  const AuthError({required this.failure});
}

class LoggedOut extends AuthState {}
