import 'package:pokey/src/core/utilities/view_state.dart';
import 'package:pokey/src/features/pokemons/model/pokemon.dart';

class PokemonState {
  final List<Pokemon> pokemons;
  final ViewState viewState;
  final String? nextUrl;

  const PokemonState._({
    required this.pokemons,
    required this.viewState,
    this.nextUrl,
  });

  factory PokemonState.initial() => const PokemonState._(
        pokemons: [],
        viewState: ViewState.idle,
      );

  PokemonState copyWith({
    List<Pokemon>? pokemons,
    ViewState? viewState,
    bool? moreDataAvailable,
    String? nextUrl,
  }) {
    return PokemonState._(
      pokemons: pokemons ?? this.pokemons,
      viewState: viewState ?? this.viewState,
      nextUrl: nextUrl,
    );
  }
}
