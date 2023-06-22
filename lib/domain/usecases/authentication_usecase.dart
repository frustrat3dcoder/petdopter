import 'package:dartz/dartz.dart';
import 'package:petdopter/core/core.dart';
import 'package:petdopter/domain/entities/user_entity.dart';
import 'package:petdopter/domain/repository/auth_repository.dart';

abstract class AuthenticationUseCase {
  Future<Either<UserEntity, Failure>> authenticateWithGoogle();
  Future<Either<bool, Failure>> logout();
}

class UserAuthUseCase extends AuthenticationUseCase {
  final AuthRepositroy repositroy;

  UserAuthUseCase({required this.repositroy});

  @override
  Future<Either<UserEntity, Failure>> authenticateWithGoogle() async {
    final result = await repositroy.signInWithGmail();
    return result;
  }

  @override
  Future<Either<bool, Failure>> logout() async {
    final result = await repositroy.loggOut();
    return result;
  }
}
