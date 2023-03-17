// ignore_for_file: depend_on_referenced_packages

import 'package:pokey/src/core/components/responsive_screen.dart';
import 'package:pokey/src/features/pokemons/model/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokey/src/core/utilities/view_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/components/spacing.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utilities/general_utility.dart';
import '../notifiers/pokemons_notifier.dart';
import 'widgets/pokemon_card.dart';

class AllPokemonView extends StatefulWidget {
  const AllPokemonView({super.key});

  @override
  State<AllPokemonView> createState() => _AllPokemonViewState();
}

class _AllPokemonViewState extends State<AllPokemonView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimensions.small,
          Dimensions.medium,
          Dimensions.small,
          Dimensions.medium,
        ),
        child: Consumer(builder: ((context, ref, child) {
          final pokemonState = ref.watch(pokemonNotifierProvider);
          if (pokemonState.viewState.isLoading) {
            return const PokemonLoadingGridView();
          } else if (pokemonState.viewState.isError) {
            return const PokemonErrorView();
          } else {
            return PokemonGridView(
              listOfPokemons: pokemonState.pokemons,
            );
          }
        })));
  }

  @override
  bool get wantKeepAlive => true;
}

class PokemonGridView extends HookConsumerWidget {
  const PokemonGridView({
    Key? key,
    required this.listOfPokemons,
  }) : super(key: key);
  final List<Pokemon> listOfPokemons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonProvider = ref.read(pokemonNotifierProvider.notifier);
    final state = ref.watch(pokemonNotifierProvider);
    final scrollController = useScrollController();

    useEffect(() {
      void scrollListener() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          pokemonProvider.getMorePokemons();
        }
      }

      scrollController.addListener(scrollListener);

      return () => scrollController.removeListener(scrollListener);
    }, [scrollController]);

    return RefreshIndicator(
      onRefresh: () => pokemonProvider.getPokemons(),
      child: GridView.builder(
        controller: scrollController,
        itemCount: listOfPokemons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: GeneralUtility.getCrossAxisCountByPlatform(context),
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
          mainAxisExtent: 200,
        ),
        itemBuilder: ((context, index) {
          if (index == listOfPokemons.length - 1 && state.nextUrl != null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final pokemon = listOfPokemons[index];
          return PokemonCard(
            pokemon: pokemon,
          );
        }),
      ),
    );
  }
}

class PokemonLoadingGridView extends StatelessWidget {
  const PokemonLoadingGridView({
    Key? key,
  }) : super(key: key);
  int getCrossAxisCountByPlatform(BuildContext context) {
    if (ResponsiveScreen.isTablet(context)) {
      return 4;
    } else if (ResponsiveScreen.isMobile(context)) {
      return 3;
    } else if (ResponsiveScreen.isLaptop(context)) {
      return 5;
    } else {
      return 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getCrossAxisCountByPlatform(context),
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        mainAxisExtent: 200,
      ),
      itemBuilder: ((context, index) {
        return Shimmer.fromColors(
          highlightColor: AppColors.grey,
          baseColor: AppColors.darkGrey,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}

class PokemonErrorView extends ConsumerWidget {
  const PokemonErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Try Again',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Spacing.bigHeight(),
          ElevatedButton(
            onPressed: () =>
                ref.refresh(pokemonNotifierProvider.notifier).getPokemons(),
            child: const Text('Get Pokemons'),
          ),
        ],
      ),
    );
  }
}
