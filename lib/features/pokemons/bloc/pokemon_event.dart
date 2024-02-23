part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class PokemoninitialFetchEvent extends PokemonEvent {}

class PokemonNavigateToTitlePageEvent extends PokemonEvent {
  final PokemonDataUiModel pokemonDetail;
  final int index;

  PokemonNavigateToTitlePageEvent(
      {required this.pokemonDetail, required this.index});
}
