import 'package:miscelaneos/domain/entities/pokemon.dart';

abstract class PokemonsDatasources {
  Future<(Pokemon?, String)> getPokemon(String id);
}
