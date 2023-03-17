import 'package:pokey/src/features/pokemons/model/pokemon.dart';
import 'package:pokey/src/features/pokemons/views/home_view.dart';
import 'package:pokey/src/features/pokemons/views/pokemon_details_view.dart';
import 'package:pokey/src/features/startup/view/startup_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const startupView = '/startupView';
  static const homeView = '/homeView';
  static const pokemonDetailsView = '/pokemonDetailsView';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startupView:
        return MaterialPageRoute(builder: (_) => const StartupView());
      case homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case pokemonDetailsView:
        final pokemon = settings.arguments as Pokemon;
        return MaterialPageRoute(
          builder: (_) => PokemonDetailsView(pokemon: pokemon),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
