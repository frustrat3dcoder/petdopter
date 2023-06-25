import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class AnimalEntityList extends Equatable {
  const AnimalEntityList({
    required this.entities,
  });

  final List<AnimalEntity> entities;

  factory AnimalEntityList.fromSnapshot(List<dynamic> snapshot) {
    final entityList = snapshot.map((data) {
      return AnimalEntity.fromJson(data);
    }).toList();
    return AnimalEntityList(entities: entityList);
  }

  @override
  List<Object?> get props => [entities];
}

class AnimalEntity extends Equatable {
  const AnimalEntity({
    required this.name,
    required this.bio,
    required this.imageUrl,
    required this.breed,
    required this.type,
    required this.traits,
    required this.age,
    required this.sex,
    required this.weight,
    required this.status,
    required this.price,
    required this.id,
    required this.ownerId,
  });

  final String? name;
  final String? bio;
  final String? imageUrl;
  final String? breed;
  final String? type;
  final List<String> traits;
  final int? age;
  final String? sex;
  final String? weight;
  final int? status;
  final int? price;
  final String? id;
  final String? ownerId;

  factory AnimalEntity.fromJson(Map<String, dynamic> json) {
    return AnimalEntity(
      name: json["name"].toString().capitalizeFirst.toString(),
      bio: json["bio"],
      imageUrl: json["image-url"],
      breed: json["breed"],
      type: json["type"],
      traits: List<String>.from(json["traits"] ?? []),
      age: json["age"],
      sex: json["sex"],
      weight: json["weight"],
      status: json["status"],
      price: json["price"],
      id: json["id"],
      ownerId: json["owner_id"] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        name,
        bio,
        imageUrl,
        breed,
        type,
        traits,
        age,
        sex,
        weight,
        status,
        price,
        id,
      ];
}
