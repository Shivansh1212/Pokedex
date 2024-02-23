// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/features/pokemons/models/pokemon_data_ui_model.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(PokemonInitial()) {
    on<PokemoninitialFetchEvent>(pokemoninitialFetchEvent);

    on<PokemonNavigateToTitlePageEvent>(pokemonNavigateToTitlePageEvent);
  }

  var pokeApi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  Future<void> pokemoninitialFetchEvent(
      PokemoninitialFetchEvent event, Emitter<PokemonState> emit) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(pokeApi));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<PokemonDataUiModel> pokemons = [];

        for (var pokemon in data['pokemon']) {
          pokemons.add(PokemonDataUiModel(
            id: pokemon['id'],
            name: pokemon['name'],
            image: pokemon['img'],
            type: List<String>.from(pokemon['type']),
            height: pokemon['height'],
            weight: pokemon['weight'],
            candy: pokemon['candy'],
            weaknesses: List<String>.from(pokemon['weaknesses']),
          ));
        }

        emit(PokemonLoadSuccess(pokemons: pokemons));
      } else {
        emit(PokemonLoadFailure(error: 'Failed to fetch data'));
      }
    } catch (e) {
      print(e.toString());
      emit(PokemonLoadFailure(error: e.toString()));
    } finally {
      client.close();
    }
  }

  FutureOr<void> pokemonNavigateToTitlePageEvent(
      PokemonNavigateToTitlePageEvent event, Emitter<PokemonState> emit) {
    emit(PokemonNavigateToTitlePageActionState(
        pokemonDetail: event.pokemonDetail,
        index: event.index,
        color: Colors.black));
  }
}
