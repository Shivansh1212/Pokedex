class PokemonDataUiModel {
  final int id;
  final String name;
  final String image;
  final List<String> type;
  final String height;
  final String weight;
  final String candy;
  final List<String> weaknesses;

  PokemonDataUiModel({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.height,
    required this.weight,
    required this.candy,
    required this.weaknesses,
  });
}




//  {
//       "id": 1,
//       "num": "001",
//       "name": "Bulbasaur",
//       "img": "http://www.serebii.net/pokemongo/pokemon/001.png",
//       "type": [
//         "Grass",
//         "Poison"
//       ],
//       "height": "0.71 m",
//       "weight": "6.9 kg",
//       "candy": "Bulbasaur Candy",
//       "candy_count": 25,
//       "egg": "2 km",
//       "spawn_chance": 0.69,
//       "avg_spawns": 69,
//       "spawn_time": "20:00",
//       "multipliers": [
//         1.58
//       ],
//       "weaknesses": [
//         "Fire",
//         "Ice",
//         "Flying",
//         "Psychic"
//       ],
//       "next_evolution": [
//         {
//           "num": "002",
//           "name": "Ivysaur"
//         },
//         {
//           "num": "003",
//           "name": "Venusaur"
//         }
//       ]
//     },