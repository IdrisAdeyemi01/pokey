import 'package:pokey/src/services/storage_service/hive_boxes.dart';
import 'package:pokey/src/services/storage_service/storage_service.dart';

import '../../features/pokemons/model/favourite_pokemon.dart';

class HiveStorageService implements StorageService {
  @override
  void addToFavourite({required int id, required FavouritePokemon pokemon}) {
    final box = HiveBoxes.getFavourites();
    box.put(id, pokemon);
  }

  @override
  void removeFromFavourite(int id) {
    final box = HiveBoxes.getFavourites();
    box.delete(id);
  }

  @override
  bool isAFavourite(int id) {
    final box = HiveBoxes.getFavourites();
    return box.containsKey(id);
  }

  @override
  int numberOfFavourites() {
    final box = HiveBoxes.getFavourites();
    return box.length;
  }
}
