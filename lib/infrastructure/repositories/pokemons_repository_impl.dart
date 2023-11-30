import 'package:miscelaneos/domain/datasoruces/pokemons_datasources.dart';
import 'package:miscelaneos/domain/entities/pokemon.dart';
import 'package:miscelaneos/domain/repositories/pokemons_repository.dart';
import 'package:miscelaneos/infrastructure/datasources/pokemons_datasources_impl.dart';

class PokemonsRepositoryImpl extends PokemonsRepository {
  final PokemonsDatasources datasources;

  PokemonsRepositoryImpl({PokemonsDatasources? datasources}) : datasources = datasources ?? PokemonsDatasourcesImpl();
  @override
  Future<(Pokemon?, String)> getPokemon(String id) {
    return datasources.getPokemon(id);
  }
}
