import 'package:pokey/src/core/components/app_svg_viewer.dart';
import 'package:pokey/src/core/router/routes.dart';
import 'package:pokey/src/features/pokemons/model/pokemon.dart';
import 'package:pokey/src/services/navigation_service/navigation_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/components/spacing.dart';
import '../../../../core/constants/constants.dart';

class PokemonCard extends ConsumerWidget {
  const PokemonCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => ref
          .read(navigationService)
          .navigateToNamed(Routes.pokemonDetailsView, arguments: pokemon),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              color: AppColors.lightGreenAccent,
              padding: const EdgeInsets.all(Dimensions.small),
              child: Center(
                  child: CachedNetworkImage(
                imageUrl: pokemon.sprite,
                height: 150,
                width: 150,
                fit: BoxFit.fill,
                errorWidget: ((context, url, error) =>
                    const AppSvgViewer(assetName: AppSvgs.pokedexIcon)),
              )),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(Dimensions.small),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#${pokemon.id.toString().padLeft(3, '0')}",
                        style: textTheme.subtitle2,
                      ),
                      const Spacing.tinyHeight(),
                      FittedBox(
                        child: Text(
                          pokemon.name[0].toUpperCase() +
                              pokemon.name.substring(1),
                        ),
                      ),
                      const Spacing.smallHeight(),
                      Text(
                        pokemon.types.join(', '),
                        style: textTheme.subtitle2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
