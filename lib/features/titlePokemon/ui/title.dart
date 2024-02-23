import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemons/models/pokemon_data_ui_model.dart';

class TitlePage extends StatefulWidget {
  final PokemonDataUiModel pokemonDetail;
  final Color color;
  final int heroTag;

  const TitlePage({
    Key? key,
    required this.pokemonDetail,
    required this.color,
    required this.heroTag,
  }) : super(key: key);

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _controller.repeat();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var weakness = widget.pokemonDetail.weaknesses.toString();

    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        children: [
          buildBackButton(),
          buildPokemonName(),
          buildRotatingPokeball(width, height),
          buildPokemonDetails(width, height, weakness),
          buildTypeText(),
          buildPokemonImage(width, height),
        ],
      ),
    );
  }

  Widget buildBackButton() {
    return Positioned(
      top: 40,
      left: 5,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildPokemonName() {
    return Positioned(
      top: 90,
      left: 20,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black54),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            widget.pokemonDetail.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRotatingPokeball(double width, double height) {
    return Positioned(
      top: height * 0.16,
      right: -30,
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
        child: Image.asset(
          'images/pokeball.png',
          height: 200,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget buildPokemonDetails(double width, double height, String weakness) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: width,
        height: height * 0.6,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildDetailRow("Pokemon Id", widget.pokemonDetail.id.toString()),
              buildDetailRow("Name", widget.pokemonDetail.name),
              buildDetailRow("Height", widget.pokemonDetail.height),
              buildDetailRow("Weight", widget.pokemonDetail.weight),
              buildDetailRow(
                "Weakness against",
                weakness.substring(1, weakness.length - 1),
              ),
              buildDetailRow("Food", widget.pokemonDetail.candy),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Text(
              label,
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTypeText() {
    return Positioned(
      top: 150,
      left: 20,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black54),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            widget.pokemonDetail.type.join(', '),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPokemonImage(double width, double height) {
    return Positioned(
      top: height * 0.16,
      left: width / 2 - 90,
      child: Hero(
        tag: widget.heroTag,
        child: CachedNetworkImage(
          imageUrl: widget.pokemonDetail.image,
          height: 200,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
