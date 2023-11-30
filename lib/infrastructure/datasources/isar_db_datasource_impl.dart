import 'package:isar/isar.dart';
import 'package:miscelaneos/domain/datasoruces/local_db_datasource.dart';
import 'package:miscelaneos/domain/entities/pokemon.dart';
import 'package:path_provider/path_provider.dart';

class IsarDBDatasource extends LocalDBDataSource {
  late Future<Isar> db;
  IsarDBDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([PokemonSchema], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> insertPokeomn({required Pokemon pokemon}) {
    // TODO: implement insertPokeomn
    throw UnimplementedError();
  }

  @override
  Future<List<Pokemon>> localPokemons() {
    // TODO: implement localPokemons
    throw UnimplementedError();
  }

  @override
  Future<int> pokemonCount() {
    // TODO: implement pokemonCount
    throw UnimplementedError();
  }
}
