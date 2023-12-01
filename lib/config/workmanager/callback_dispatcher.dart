import 'package:miscelaneos/infrastructure/repositories/local_db_repository_impl.dart';
import 'package:miscelaneos/infrastructure/repositories/pokemons_repository_impl.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey = 'com.pablovalera.miscelaneos.fetch-background-pokemon';
const fetchPeriodicTaskKey = 'com.pablovalera.miscelaneos.fetch-background-pokemon';

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackgroundTaskKey:
        await loadNextPokemon();
        break;
      case fetchPeriodicTaskKey:
        print('fetchPeriodicTaskKey');
        break;
      case Workmanager.iOSBackgroundTask:
        print('iosBack');
    }
    return Future.value(true);
  });
}

Future loadNextPokemon() async {
  final localDBRepository = LocalDbRepositoryImpl();
  final pokemonRepository = PokemonsRepositoryImpl();
  final lastPokemonID = await localDBRepository.pokemonCount() + 1;
  try {
    final (pokemon, message) = await pokemonRepository.getPokemon('$lastPokemonID');
    if (pokemon == null) throw message;

    await localDBRepository.insertPokeomn(pokemon: pokemon);
    print('pokemon inserted: ${pokemon.name}');
  } catch (e) {
    print('$e');
  }
}
