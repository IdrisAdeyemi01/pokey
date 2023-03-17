import 'package:pokey/src/core/components/app_svg_viewer.dart';
import 'package:pokey/src/core/components/spacing.dart';
import 'package:pokey/src/core/components/status_bar.dart';
import 'package:pokey/src/core/utilities/model_converter.dart';
import 'package:pokey/src/services/navigation_service/navigation_service.dart';
import 'package:pokey/src/services/storage_service/storage_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../services/storage_service/hive_boxes.dart';
import '../model/favourite_pokemon.dart';
import '../model/pokemon.dart';

class PokemonDetailsView extends ConsumerWidget {
  const PokemonDetailsView({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final hiveStorage = ref.watch(storageService);
    return Statusbar(
      statusBarColor: AppColors.lightGreenAccent,
      systemNavigationBarColor: AppColors.cartonBackgroundColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      child: Scaffold(
        backgroundColor: AppColors.cartonBackgroundColor,
        floatingActionButton: ValueListenableBuilder<Box<FavouritePokemon>>(
            valueListenable: HiveBoxes.getFavourites().listenable(),
            builder: (context, box, _) {
              return box.containsKey(pokemon.id)
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightPurple),
                      child: Text(
                        AppStrings.removeFromFavourites,
                        style: textTheme.bodyText2!
                            .copyWith(color: AppColors.primary),
                      ),
                      onPressed: () =>
                          hiveStorage.removeFromFavourite(pokemon.id),
                    )
                  : ElevatedButton(
                      child: const Text(AppStrings.markAsFavourite),
                      onPressed: () => hiveStorage.addToFavourite(
                          id: pokemon.id,
                          pokemon: ModelConverter.toFavouritePokemon(pokemon)));
            }),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.lightGreenAccent,
                elevation: 10,
                leading: InkWell(
                  onTap: () => ref.read(navigationService).navigateBack(),
                  child: const Icon(
                    Icons.chevron_left,
                    color: AppColors.dark,
                  ),
                ),
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      const Positioned(
                        bottom: -15,
                        right: -5,
                        child: AppSvgViewer(
                          assetName: AppSvgs.pokemonBackground,
                          height: 180,
                          width: 180,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          Dimensions.medium,
                          40,
                          Dimensions.medium,
                          Dimensions.small,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pokemon.name[0].toUpperCase() +
                                      pokemon.name.substring(1),
                                  style: textTheme.headline5!
                                      .copyWith(fontSize: 32),
                                ),
                                Text(
                                  pokemon.types.join(', '),
                                  style: textTheme.headline6,
                                ),
                                const Spacer(),
                                Text(
                                  '#${pokemon.id.toString().padLeft(3, '0')}',
                                  style: textTheme.headline6,
                                ),
                              ],
                            ),
                            CachedNetworkImage(
                              imageUrl: pokemon.sprite,
                              height: 150,
                              width: 150,
                              fit: BoxFit.fill,
                              errorWidget: ((context, url, error) =>
                                  const AppSvgViewer(
                                      assetName: AppSvgs.pokedexIcon)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                    color: AppColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(Dimensions.medium),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.height,
                                        style: textTheme.subtitle2,
                                      ),
                                      const Spacing.tinyHeight(),
                                      Text(
                                        '${pokemon.height}',
                                        style: textTheme.bodyText1,
                                      ),
                                    ],
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.weight,
                                        style: textTheme.subtitle2,
                                      ),
                                      const Spacing.tinyHeight(),
                                      Text('${pokemon.weight}',
                                          style: textTheme.bodyText1),
                                    ],
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.bmi,
                                        style: textTheme.subtitle2,
                                      ),
                                      const Spacing.tinyHeight(),
                                      Text(pokemon.bmi,
                                          style: textTheme.bodyText1),
                                    ],
                                  ),
                                  const Spacer(
                                    flex: 5,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: Dimensions.small,
                              color: AppColors.cartonBackgroundColor,
                            ),
                          ],
                        ),
                        _AllBaseStatsColumn(pokemon: pokemon),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AllBaseStatsColumn extends StatelessWidget {
  const _AllBaseStatsColumn({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                Dimensions.medium,
                Dimensions.small,
                Dimensions.medium,
                Dimensions.small,
              ),
              child: Text(AppStrings.baseStats),
            ),
            const Divider(
              thickness: 2,
              color: AppColors.grey,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimensions.medium,
                Dimensions.small,
                Dimensions.medium,
                Dimensions.medium,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StatsColumn(
                      title: AppStrings.hp,
                      value: pokemon.hp,
                    ),
                    _StatsColumn(
                      title: AppStrings.attack,
                      value: pokemon.attack,
                    ),
                    _StatsColumn(
                      title: AppStrings.defense,
                      value: pokemon.defense,
                    ),
                    _StatsColumn(
                      title: AppStrings.specialAttack,
                      value: pokemon.specialAttack,
                    ),
                    _StatsColumn(
                      title: AppStrings.specialDefense,
                      value: pokemon.specialDefense,
                    ),
                    _StatsColumn(
                      title: AppStrings.speed,
                      value: pokemon.speed,
                    ),
                    _StatsColumn(
                      title: AppStrings.avgPower,
                      value: pokemon.averagePower,
                    ),
                  ]),
            ),
          ],
        )
      ],
    );
  }
}

class _StatsColumn extends StatelessWidget {
  const _StatsColumn({
    Key? key,
    this.value = 0,
    required this.title,
  }) : super(key: key);

  final int value;
  final String title;

  // This method helps to get the stat's line color based on the its value
  // Convention (After conversion): (0 - 30 -> Red), (31 - 70 -> Yellow), (71 - 100 -> Green)
  // From research: I read that the max for these stats is 255

  Color _getLineColor(int value) {
    final statValue = value / 100 * 255;
    if (statValue > 0 && statValue <= 30) {
      return AppColors.red;
    } else if (statValue > 30 && statValue <= 70) {
      return AppColors.statYellow;
    } else {
      return AppColors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: textTheme.bodyText1,
            ),
            const Spacing.smallWidth(),
            Text('$value'),
          ],
        ),
        const Spacing.smallHeight(),
        Container(
          height: Dimensions.tiny,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.big),
            color: AppColors.grey,
          ),
          child: Row(children: [
            Container(
              height: Dimensions.tiny,
              width: MediaQuery.of(context).size.width * value / 255,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.big),
                  color: _getLineColor(value)),
            ),
            const Expanded(
              child: SizedBox(),
            )
          ]),
        ),
        const Spacing.bigHeight(),
      ],
    );
  }
}
