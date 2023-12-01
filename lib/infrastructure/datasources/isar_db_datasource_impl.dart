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
  Future<void> insertPokeomn({required Pokemon pokemon}) async {
    final isar = await db;
    final done = isar.writeTxnSync(() => isar.pokemons.putSync(pokemon));
    print(done);
  }

  @override
  Future<List<Pokemon>> localPokemons() async {
    final isar = await db;
    return isar.pokemons.where().findAll();
  }

  @override
  Future<int> pokemonCount() async {
    final isar = await db;
    return isar.pokemons.count();
  }
}
