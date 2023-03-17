// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouritePokemonAdapter extends TypeAdapter<FavouritePokemon> {
  @override
  final int typeId = 0;

  @override
  FavouritePokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouritePokemon(
      name: fields[0] as String,
      id: fields[1] as int,
      types: (fields[2] as List).cast<String>(),
      sprite: fields[3] as String,
      weight: fields[4] as int,
      height: fields[5] as int,
      hp: fields[6] as int,
      attack: fields[7] as int,
      defense: fields[8] as int,
      specialAttack: fields[9] as int,
      specialDefense: fields[10] as int,
      speed: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FavouritePokemon obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.types)
      ..writeByte(3)
      ..write(obj.sprite)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.height)
      ..writeByte(6)
      ..write(obj.hp)
      ..writeByte(7)
      ..write(obj.attack)
      ..writeByte(8)
      ..write(obj.defense)
      ..writeByte(9)
      ..write(obj.specialAttack)
      ..writeByte(10)
      ..write(obj.specialDefense)
      ..writeByte(11)
      ..write(obj.speed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritePokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
