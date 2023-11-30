import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/plugins/share_pluggin.dart';
import 'package:miscelaneos/domain/entities/pokemon.dart';
import 'package:miscelaneos/presentation/providers/pokemons/pokemon_provider.dart';

class PokemonScreen extends ConsumerWidget {
  final String pokemonID;
  const PokemonScreen({super.key, required this.pokemonID});

  @override
  Widget build(BuildContext context, ref) {
    final pokemonAsync = ref.watch(pokemonProvider(pokemonID));
    return pokemonAsync.when(data: (pokemon) {
      return _PokemonView(pokemon: pokemon);
    }, error: (error, stackTrace) {
      return _ErrorWidget(message: error.toString());
    }, loading: () {
      return const _LoadingWidget();
    });
  }
}

class _PokemonView extends StatelessWidget {
  final Pokemon pokemon;
  const _PokemonView({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        actions: [
          IconButton(
              onPressed: () {
                // Link = Deeplink
                SharePlugin.shareLink('https://pokemon-flt-deep.up.railway.app/pokemons/${pokemon.id}/', 'Mira este Pokemon');
              },
              icon: const Icon(Icons.share_outlined))
        ],
      ),
      body: Center(
        child: Image.network(
          pokemon.spriteFront,
          fit: BoxFit.contain,
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  const _ErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
