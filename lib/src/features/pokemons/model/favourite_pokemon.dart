import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'favourite_pokemon.g.dart';

@HiveType(typeId: 0)
class FavouritePokemon extends HiveObject {
  
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int id;

  @HiveField(2)
  final List<String> types;

  @HiveField(3)
  final String sprite;

  @HiveField(4)
  final int weight;

  @HiveField(5)
  final int height;

  @HiveField(6)
  final int hp;

  @HiveField(7)
  final int attack;

  @HiveField(8)
  final int defense;

  @HiveField(9)
  final int specialAttack;

  @HiveField(10)
  final int specialDefense;

  @HiveField(11)
  final int speed;

  FavouritePokemon({
    required this.name,
    required this.id,
    required this.types,
    required this.sprite,
    required this.weight,
    required this.height,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  FavouritePokemon copyWith({
    String? name,
    int? id,
    List<String>? types,
    String? sprite,
    int? weight,
    int? height,
    int? hp,
    int? attack,
    int? defense,
    int? specialAttack,
    int? specialDefense,
    int? speed,
  }) {
    return FavouritePokemon(
      name: name ?? this.name,
      id: id ?? this.id,
      types: types ?? this.types,
      sprite: sprite ?? this.sprite,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      hp: hp ?? this.hp,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
      specialAttack: specialAttack ?? this.specialAttack,
      specialDefense: specialDefense ?? this.specialDefense,
      speed: speed ?? this.speed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'types': types,
      'sprite': sprite,
      'weight': weight,
      'height': height,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'specialAttack': specialAttack,
      'specialDefense': specialDefense,
      'speed': speed,
    };
  }

  factory FavouritePokemon.fromMap(Map<String, dynamic> map) {
    return FavouritePokemon(
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
      types: List<String>.from(map['types']),
      sprite: map['sprite'] ?? '',
      weight: map['weight']?.toInt() ?? 0,
      height: map['height']?.toInt() ?? 0,
      hp: map['hp']?.toInt() ?? 0,
      attack: map['attack']?.toInt() ?? 0,
      defense: map['defense']?.toInt() ?? 0,
      specialAttack: map['specialAttack']?.toInt() ?? 0,
      specialDefense: map['specialDefense']?.toInt() ?? 0,
      speed: map['speed']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouritePokemon.fromJson(String source) =>
      FavouritePokemon.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FavouritePokemon(name: $name, id: $id, types: $types, sprite: $sprite, weight: $weight, height: $height, hp: $hp, attack: $attack, defense: $defense, specialAttack: $specialAttack, specialDefense: $specialDefense, speed: $speed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavouritePokemon &&
        other.name == name &&
        other.id == id &&
        listEquals(other.types, types) &&
        other.sprite == sprite &&
        other.weight == weight &&
        other.height == height &&
        other.hp == hp &&
        other.attack == attack &&
        other.defense == defense &&
        other.specialAttack == specialAttack &&
        other.specialDefense == specialDefense &&
        other.speed == speed;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        types.hashCode ^
        sprite.hashCode ^
        weight.hashCode ^
        height.hashCode ^
        hp.hashCode ^
        attack.hashCode ^
        defense.hashCode ^
        specialAttack.hashCode ^
        specialDefense.hashCode ^
        speed.hashCode;
  }
}
