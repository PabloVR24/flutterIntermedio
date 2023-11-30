import 'package:miscelaneos/domain/entities/pokemon.dart';
import 'package:miscelaneos/infrastructure/models/pokeapi_response.dart';

class PokemonMapper {
  static Pokemon pokeApiToEntity(Map<String, dynamic> json) {
    final pokeApiPokemon = PokeApiResponse.fromJson(json);
    return Pokemon(id: pokeApiPokemon.id, name: pokeApiPokemon.name, spriteFront: pokeApiPokemon.sprites.frontDefault);
  }
}
