import 'package:pokey/src/core/components/app_svg_viewer.dart';
import 'package:pokey/src/core/components/spacing.dart';
import 'package:pokey/src/core/components/status_bar.dart';
import 'package:pokey/src/core/constants/constants.dart';
import 'package:pokey/src/features/pokemons/views/favourite_pokemons_view.dart';
import 'package:pokey/src/features/pokemons/views/all_pokemon_view.dart';
import 'package:pokey/src/features/pokemons/views/widgets/custom_tab_bar_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../services/storage_service/hive_boxes.dart';
import '../model/favourite_pokemon.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Statusbar(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.cartonBackgroundColor,
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
              backgroundColor: AppColors.cartonBackgroundColor,
              appBar: AppBar(
                backgroundColor: AppColors.white,
                elevation: 0,
                centerTitle: true,
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const AppSvgViewer(assetName: AppSvgs.pokedexIcon),
                  const Spacing.tinyWidth(),
                  Text(
                    AppStrings.pokedex,
                    style: textTheme.headline5,
                  ),
                ]),
                bottom: TabBar(indicator: const CustomTabIndicator(), tabs: [
                  const Tab(
                    child: Text(
                      AppStrings.allPokemons,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.black),
                    ),
                  ),
                  Tab(
                      child: ValueListenableBuilder<Box<FavouritePokemon>>(
                    valueListenable: HiveBoxes.getFavourites().listenable(),
                    builder: (context, box, _) {
                      int lengthOfFavouritePokemons = box.length;
                      return lengthOfFavouritePokemons == 0
                          ? const Text(
                              AppStrings.favourites,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.darkPurple),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  const Text(
                                    AppStrings.favourites,
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(color: AppColors.darkPurple),
                                  ),
                                  const Spacing.tinyWidth(),
                                  CircleAvatar(
                                      radius: 10,
                                      backgroundColor: AppColors.primary,
                                      child: FittedBox(
                                        child: Text(
                                          '$lengthOfFavouritePokemons ',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ))
                                ]);
                    },
                  ))
                ]),
              ),
              body: const TabBarView(
                children: [
                  AllPokemonView(),
                  FavouritePokemonsView(),
                ],
              )),
        ),
      ),
    );
  }
}
