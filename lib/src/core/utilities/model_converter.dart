import 'package:pokey/src/features/pokemons/model/favourite_pokemon.dart';
import 'package:pokey/src/features/pokemons/model/pokemon.dart';

class ModelConverter {
  static FavouritePokemon toFavouritePokemon(Pokemon pokemon) {
    return FavouritePokemon(
      name: pokemon.name,
      id: pokemon.id,
      types: pokemon.types,
      sprite: pokemon.sprite,
      weight: pokemon.weight,
      height: pokemon.height,
      hp: pokemon.hp,
      attack: pokemon.attack,
      defense: pokemon.defense,
      specialAttack: pokemon.specialAttack,
      specialDefense: pokemon.specialDefense,
      speed: pokemon.speed,
    );
  }

  static Pokemon toPokemon(FavouritePokemon pokemon) {
    return Pokemon(
      name: pokemon.name,
      id: pokemon.id,
      types: pokemon.types,
      sprite: pokemon.sprite,
      weight: pokemon.weight,
      height: pokemon.height,
      hp: pokemon.hp,
      attack: pokemon.attack,
      defense: pokemon.defense,
      specialAttack: pokemon.specialAttack,
      specialDefense: pokemon.specialDefense,
      speed: pokemon.speed,
    );
  }
}
