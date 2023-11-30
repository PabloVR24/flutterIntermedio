import 'package:dio/dio.dart';
import 'package:miscelaneos/domain/datasoruces/pokemons_datasources.dart';
import 'package:miscelaneos/domain/entities/pokemon.dart';
import 'package:miscelaneos/infrastructure/mappers/pokemon_mapper.dart';

class PokemonsDatasourcesImpl extends PokemonsDatasources {
  final Dio dio;

  PokemonsDatasourcesImpl() : dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/'));

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    try {
      final resp = await dio.get('/pokemon/$id');
      final pokemon = PokemonMapper.pokeApiToEntity(resp.data);
      return (pokemon, 'Data obtenida');
    } catch (e) {
      return (null, 'Error al obtener $e');
    }
  }
}
