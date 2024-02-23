import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemons/bloc/pokemon_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/titlePokemon/ui/title.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({Key? key}) : super(key: key);

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final PokemonBloc pokemonBloc = PokemonBloc();

  @override
  void initState() {
    pokemonBloc.add(PokemoninitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFD51347),
      body: BlocConsumer<PokemonBloc, PokemonState>(
        listenWhen: (previous, current) => current is PokemoActionState,
        buildWhen: (previous, current) => current is! PokemoActionState,
        listener: (context, state) {
          if (state is PokemonNavigateToTitlePageActionState) {
            final pokeType = state.pokemonDetail.type[0].toString();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TitlePage(
                        pokemonDetail: state.pokemonDetail,
                        color: pokeType == 'Grass'
                            ? const Color.fromARGB(255, 88, 192, 142)
                            : pokeType == 'Fire'
                                ? Colors.redAccent
                                : pokeType == "Water"
                                    ? Colors.blue
                                    : pokeType == "Electric"
                                        ? Colors.yellow.shade700
                                        : pokeType == "Normal"
                                            ? Colors.pink
                                            : pokeType == "Poison"
                                                ? Colors.purpleAccent
                                                : pokeType == "Psychic"
                                                    ? Colors.amber
                                                    : pokeType == "Rock"
                                                        ? Colors.grey
                                                        : pokeType == "Ground"
                                                            ? Colors.brown
                                                            : pokeType ==
                                                                    "Fighting"
                                                                ? Colors.orange
                                                                : pokeType ==
                                                                        "Ghost"
                                                                    ? Colors
                                                                        .indigo
                                                                    : pokeType ==
                                                                            "Dragon"
                                                                        ? Colors
                                                                            .blueGrey
                                                                        : pokeType ==
                                                                                "Bug"
                                                                            ? Colors.teal.shade800
                                                                            : pokeType == "Ice"
                                                                                ? Colors.lightBlue
                                                                                : Colors.black,
                        heroTag: state.index)));
          }
        },
        bloc: pokemonBloc,
        builder: (context, state) {
          if (state is PokemonLoadSuccess) {
            return Stack(
              children: [
                Positioned(
                  top: -50,
                  right: -50,
                  child: Image.asset(
                    'images/pokeball.png',
                    width: 200,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Image.asset(
                    'images/pokedex.png',
                    scale: 2,
                  ),
                ),
                Positioned(
                  top: 130,
                  bottom: 0,
                  width: width,
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1.2),
                          itemCount: state.pokemons.length,
                          itemBuilder: (context, index) {
                            final pokemon = state.pokemons[index];
                            final imageurl = pokemon.image;
                            final pokeType = pokemon.type[0].toString();
                            return InkWell(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                      color: pokeType == 'Grass'
                                          ? const Color.fromARGB(
                                              255, 88, 192, 142)
                                          : pokeType == 'Fire'
                                              ? Colors.redAccent
                                              : pokeType == "Water"
                                                  ? Colors.blue
                                                  : pokeType == "Electric"
                                                      ? Colors.yellow.shade700
                                                      : pokeType == "Normal"
                                                          ? Colors.pink
                                                          : pokeType == "Poison"
                                                              ? Colors
                                                                  .purpleAccent
                                                              : pokeType ==
                                                                      "Psychic"
                                                                  ? Colors.amber
                                                                  : pokeType ==
                                                                          "Rock"
                                                                      ? Colors
                                                                          .grey
                                                                      : pokeType ==
                                                                              "Ground"
                                                                          ? Colors
                                                                              .brown
                                                                          : pokeType == "Fighting"
                                                                              ? Colors.orange
                                                                              : pokeType == "Ghost"
                                                                                  ? Colors.indigo
                                                                                  : pokeType == "Dragon"
                                                                                      ? Colors.blueGrey
                                                                                      : pokeType == "Bug"
                                                                                          ? Colors.teal.shade800
                                                                                          : pokeType == "Ice"
                                                                                              ? Colors.lightBlue
                                                                                              : Colors.black),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: -10,
                                        right: -10,
                                        child: Image.asset(
                                          'images/pokeball.png',
                                          height: 100,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Positioned(
                                        top: 20,
                                        left: 15,
                                        child: Text(
                                          pokemon.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Positioned(
                                        top: 50,
                                        left: 10,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color: Colors.black26),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6),
                                            child: Text(
                                              pokeType,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: Hero(
                                          tag: index,
                                          child: CachedNetworkImage(
                                            imageUrl: imageurl,
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                pokemonBloc.add(PokemonNavigateToTitlePageEvent(
                                  pokemonDetail: pokemon,
                                  index: index,
                                ));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is PokemonLoadFailure) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
