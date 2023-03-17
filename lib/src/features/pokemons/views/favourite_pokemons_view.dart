import 'package:pokey/src/core/utilities/general_utility.dart';
import 'package:pokey/src/core/utilities/model_converter.dart';
import 'package:pokey/src/features/pokemons/model/favourite_pokemon.dart';
import 'package:pokey/src/services/storage_service/hive_boxes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/constants.dart';
import 'widgets/pokemon_card.dart';

class FavouritePokemonsView extends ConsumerWidget {
  const FavouritePokemonsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final pokemonProvider = ref.watch(pokemonNotifierProvider.notifier);
    // final pokemonState = ref.watch(pokemonNotifierProvider);
    return Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimensions.small,
          Dimensions.medium,
          Dimensions.small,
          Dimensions.medium,
        ),
        child: ValueListenableBuilder<Box<FavouritePokemon>>(
            valueListenable: HiveBoxes.getFavourites().listenable(),
            builder: (context, box, _) {
              final favouritePokemons =
                  box.values.toList().cast<FavouritePokemon>();

              if (favouritePokemons.isEmpty) {
                return const Center(
                  child: Text(
                    'You have not added any favourite Pokemon',
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return FavouritePokemonGridView(
                  favouritePokemons: favouritePokemons,
                );
              }
            })
        // FavouritePokemonGridView(),
        );
  }
}

class FavouritePokemonGridView extends StatelessWidget {
  const FavouritePokemonGridView({
    Key? key,
    required this.favouritePokemons,
  }) : super(key: key);
  final List<FavouritePokemon> favouritePokemons;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: favouritePokemons.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: GeneralUtility.getCrossAxisCountByPlatform(context),
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        mainAxisExtent: 200,
      ),
      itemBuilder: ((context, index) {
        return PokemonCard(
          pokemon: ModelConverter.toPokemon(favouritePokemons[index]),
        );
      }),
    );
  }
}
