import 'package:miscelaneos/domain/datasoruces/local_db_datasource.dart';
import 'package:miscelaneos/domain/entities/pokemon.dart';
import 'package:miscelaneos/domain/repositories/local_db_repository.dart';
import 'package:miscelaneos/infrastructure/datasources/isar_db_datasource_impl.dart';

class LocalDbRepositoryImpl extends LocalDBRepository {
  final LocalDBDataSource _dataSource;

  LocalDbRepositoryImpl([LocalDBDataSource? dataSource]) : _dataSource = dataSource ?? IsarDBDatasource();
  @override
  Future<void> insertPokeomn({required Pokemon pokemon}) => _dataSource.insertPokeomn(pokemon: pokemon);

  @override
  Future<List<Pokemon>> localPokemons() => _dataSource.localPokemons();

  @override
  Future<int> pokemonCount() => _dataSource.pokemonCount();
}
