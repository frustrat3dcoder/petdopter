import 'package:dartz/dartz.dart';
import 'package:petdopter/core/core.dart';
import 'package:petdopter/domain/entities/user_entity.dart';

abstract class AuthRepositroy {
  Future<Either<UserEntity, Failure>> signInWithGmail();
}
