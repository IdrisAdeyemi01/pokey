import 'package:pokey/src/core/utilities/model_converter.dart';
import 'package:pokey/src/services/base/failure.dart';
import 'package:pokey/src/services/storage_service/storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/pokemons/model/pokemon.dart';
import '../services/base/api_data.dart';
import '../services/network_service/network_service.dart';

class PokemonsRepository {
  final NetworkService networkService;
  final StorageService storageService;

  PokemonsRepository(
      {required this.networkService, required this.storageService});

  Future<Pokemon> _getCurrentPokemon(String url) async {
    final uri = APIData.fetchPokemonsFromUrl(url);
    final response = await networkService.get(uri) as Map<String, dynamic>;
    int currentPokemonId = response["id"];
    bool isFavourite = storageService.isAFavourite(currentPokemonId);
    if (isFavourite) {
      Pokemon currentPokemon = Pokemon.fromMap(response);
      storageService.addToFavourite(
        id: currentPokemonId,
        pokemon: ModelConverter.toFavouritePokemon(currentPokemon),
      );
    }

    return Pokemon.fromMap(response);
  }

  Future<Map<String, dynamic>> getPokemons({
    int offset = 0,
    int limit = 30,
  }) async {
    try {
      final query = "offset=$offset&limit=$limit";
      final uri = APIData.fetchPokemons(query: query);
      final response = await networkService.get(uri) as Map<String, dynamic>;
      final next = response["next"];
      final results = response["results"];
      List<Future<Pokemon>> futures = [];
      for (var result in results) {
        String? url = result["url"];
        futures.add(_getCurrentPokemon(url!));
      }

      List<Pokemon> pokemons = await Future.wait(futures);

      return {
        "next": next,
        "listOfPokemons": List<Pokemon>.from(pokemons),
      };
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<Map<String, dynamic>> getMorePokemons(
      {required String nextUrl}) async {
    final uri = APIData.fetchPokemonsFromUrl(nextUrl);
    final response = await networkService.get(uri) as Map<String, dynamic>;
    final next = response["next"];
    final results = response["results"];

    List<Future<Pokemon>> futures = [];
    for (var result in results) {
      String? url = result["url"];
      futures.add(_getCurrentPokemon(url!));
    }

    var pokemons = await Future.wait(futures);
    return {
      "next": next,
      "listOfPokemons": List<Pokemon>.from(pokemons),
    };
  }
}

final pokemonsRepository = Provider<PokemonsRepository>(
  (ref) => PokemonsRepository(
    networkService: ref.watch(networkService),
    storageService: ref.read(storageService),
  ),
);
