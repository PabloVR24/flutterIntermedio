import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/domain/entities/pokemon.dart';
import 'package:miscelaneos/infrastructure/repositories/local_db_repository_impl.dart';

final pokemonDBProvider = FutureProvider.autoDispose<List<Pokemon>>((ref) async {
  final localDB = LocalDbRepositoryImpl();
  final pokemons = await localDB.localPokemons();
  return pokemons;
});
