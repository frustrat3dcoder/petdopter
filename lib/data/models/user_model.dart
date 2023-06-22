import 'package:equatable/equatable.dart';
import 'package:petdopter/domain/entities/user_entity.dart';

class UserModel extends UserEntity with EquatableMixin {
  // @override
  // final String id;
  // @override
  // final String name;
  // @override
  // final String email;
  // @override
  // final String profileImage;

  UserModel({required id, required email, required name, required profileImage})
      : super(email: email, id: id, name: name, profileImage: profileImage);
}
