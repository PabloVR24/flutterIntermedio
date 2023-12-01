import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/workmanager/callback_dispatcher.dart';
import 'package:miscelaneos/domain/entities/pokemon.dart';
import 'package:miscelaneos/presentation/providers/background_tasks/backgroud_tasks_provider.dart';
import 'package:miscelaneos/presentation/providers/pokemons/pokemon_db_provider.dart';
import 'package:workmanager/workmanager.dart';

class DbPokemonsScrenn extends ConsumerWidget {
  const DbPokemonsScrenn({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final pokemonsAsync = ref.watch(pokemonDBProvider);
    final isPokemonActive = ref.watch(backgroundFetchProvider);
    if (pokemonsAsync.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final List<Pokemon> pokemons = pokemonsAsync.value ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Process'),
        actions: [
          IconButton(
              onPressed: () {
                Workmanager().registerOneOffTask(fetchBackgroundTaskKey, fetchBackgroundTaskKey,
                    initialDelay: const Duration(seconds: 3), inputData: {'howMany': 30});
              },
              icon: const Icon(Icons.add_alarm_sharp))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          _PokemonsGrid(
            pokemons: pokemons,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(backgroundFetchProvider.notifier).toggleProcess();
        },
        label: isPokemonActive ? const Text('Desactivar fetch periodico') : const Text('Activar fetch periodico'),
        icon: const Icon(Icons.av_timer),
      ),
    );
  }
}

// ignore: unused_element
class _PokemonsGrid extends StatelessWidget {
  final List<Pokemon> pokemons;
  const _PokemonsGrid({required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];

        return Column(
          children: [
            Image.network(
              pokemon.spriteFront,
              fit: BoxFit.contain,
            ),
            Text(pokemon.name)
          ],
        );
      },
    );
  }
}
