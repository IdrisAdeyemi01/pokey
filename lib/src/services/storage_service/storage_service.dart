import 'package:pokey/src/services/storage_service/hive_storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/pokemons/model/favourite_pokemon.dart';

abstract class StorageService {
  bool isAFavourite(int id);

  void addToFavourite({required int id, required FavouritePokemon pokemon});

  void removeFromFavourite(int id);

  int numberOfFavourites();
}

final storageService =
    Provider<StorageService>(((ref) => HiveStorageService()));
