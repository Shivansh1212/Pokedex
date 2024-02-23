part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {}

abstract class PokemoActionState extends PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoadSuccess extends PokemonState {
  final List<PokemonDataUiModel> pokemons;

  PokemonLoadSuccess({required this.pokemons});
}

class PokemonLoadFailure extends PokemonState {
  final String error;

  PokemonLoadFailure({required this.error});
}

class PokemonNavigateToTitlePageActionState extends PokemoActionState {
  final PokemonDataUiModel pokemonDetail;
  final int index;
  final Color color;

  PokemonNavigateToTitlePageActionState( 
      {required this.color, required this.pokemonDetail, required this.index});
}
