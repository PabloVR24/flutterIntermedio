import 'package:miscelaneos/domain/entities/pokemon.dart';

abstract class LocalDBRepository {
  Future<List<Pokemon>> localPokemons();
  Future<int> pokemonCount();
  Future<void> insertPokeomn({required Pokemon pokemon});
}
