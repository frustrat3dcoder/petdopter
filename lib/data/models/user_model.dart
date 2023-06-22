import 'package:equatable/equatable.dart';
import 'package:petdopter/domain/entities/user_entity.dart';

class UserModel extends UserEntity with EquatableMixin {
  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String profileImage;

  UserModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.profileImage})
      : super(email: email, id: id, name: name, profileImage: profileImage);
}
