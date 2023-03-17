import 'package:pokey/src/core/utilities/view_state.dart';
import 'package:pokey/src/features/pokemons/state/pokemon_state.dart';
import 'package:pokey/src/repositories/pokemons_repository.dart';
import 'package:pokey/src/services/snackbar_service/snackbar_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../services/base/failure.dart';
import '../model/pokemon.dart';

class PokemonNotifier extends StateNotifier<PokemonState> {
  PokemonNotifier(this._ref) : super(PokemonState.initial()) {
    getPokemons();
  }

  final Ref _ref;

  Future<void> getPokemons() async {
    try {
      state = state.copyWith(viewState: ViewState.loading);
      final pokemons = await _ref.read(pokemonsRepository).getPokemons();
      final List<Pokemon> listOfPokemons = pokemons["listOfPokemons"];
      final nextUrl = pokemons["next"];

      state = state.copyWith(
        pokemons: listOfPokemons,
        nextUrl: nextUrl,
        viewState: ViewState.idle,
      );
    } on Failure {
      _ref
          .read(snackbarService)
          .showErrorSnackBar('An error occured while fetching pokemons');
      state = state.copyWith(viewState: ViewState.error);
    }
  }

  Future<void> getMorePokemons() async {
    try {
      if (state.nextUrl == null) {
        _ref
            .read(snackbarService)
            .showErrorSnackBar('You have reached the end of the list');
      } else {
        final pokemons = await _ref
            .read(pokemonsRepository)
            .getMorePokemons(nextUrl: state.nextUrl!);
        final listOfPokemons = pokemons["listOfPokemons"];
        final nextUrl = pokemons["next"];
        state = state.copyWith(
            pokemons: [...state.pokemons, ...listOfPokemons], nextUrl: nextUrl);
      }
    } on Failure {
      _ref
          .read(snackbarService)
          .showErrorSnackBar('An error occured while fetching pokemons');
      state = state.copyWith(viewState: ViewState.error);
    } finally {
      state = state.copyWith(viewState: ViewState.idle, nextUrl: state.nextUrl);
    }
  }
}

final pokemonNotifierProvider =
    StateNotifierProvider<PokemonNotifier, PokemonState>(
        ((ref) => PokemonNotifier(ref)));
