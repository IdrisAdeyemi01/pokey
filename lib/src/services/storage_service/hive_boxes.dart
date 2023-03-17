import 'package:pokey/src/features/pokemons/model/favourite_pokemon.dart';
import 'package:hive/hive.dart';

class HiveBoxes {
  static Box<FavouritePokemon> getFavourites() =>
      Hive.box<FavouritePokemon>('favouritePokemons');
}
