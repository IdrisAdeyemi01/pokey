import 'package:flutter/foundation.dart';

class Pokemon {
  final String name;
  final int id;
  final List<String> types;
  final String sprite;
  final int weight;
  final int height;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  Pokemon({
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

  Pokemon copyWith({
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
    return Pokemon(
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

  String get bmi {
    double bmi = weight / (height * height);
    return bmi.toStringAsFixed(2);
  }

  int get averagePower {
    List powers = [hp, attack, defense, specialAttack, specialDefense, speed ];
    int numberOfPower = 0;
    int powerSum = 0;
    for (int? power in powers) {
      if (power != null) {
        powerSum += power;
        numberOfPower += 1;
      }
    }
    if (numberOfPower == 0) return 0;
    return powerSum ~/ numberOfPower;
  }



  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
      types: map["types"] == null
          ? []
          : List<String>.from(map["types"].map((type) {
              String tp = type["type"]["name"];
              return tp[0].toUpperCase() + tp.substring(1);
            })),
      sprite: map['sprites'] == null
          ? ''
          : map["sprites"]["other"]["official-artwork"]["front_default"],
      weight: map['weight']?.toInt() ?? 0,
      height: map['height']?.toInt() ?? 0,
      hp: map['stats'][0]["base_stat"]?.toInt() ?? 0,
      attack: map['stats'][1]["base_stat"]?.toInt() ?? 0,
      defense: map['stats'][2]["base_stat"]?.toInt() ?? 0,
      specialAttack: map['stats'][3]["base_stat"]?.toInt() ?? 0,
      specialDefense: map['stats'][4]["base_stat"]?.toInt() ?? 0,
      speed: map['stats'][5]["base_stat"]?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'Pokemon(name: $name, id: $id, types: $types, sprite: $sprite, weight: $weight, height: $height, hp: $hp, attack: $attack, defense: $defense, specialAttack: $specialAttack, specialDefense: $specialDefense, speed: $speed, )';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pokemon &&
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
