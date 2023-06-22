import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profileImage;

  const UserEntity(
      {required this.id,
      required this.name,
      required this.email,
      required this.profileImage});

  @override
  List<Object?> get props => [id, name, email];
}
