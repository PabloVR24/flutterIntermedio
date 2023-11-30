import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/providers/pokemons/pokemon_list_provider.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _PokemonsView(),
    );
  }
}

class _PokemonsView extends ConsumerStatefulWidget {
  const _PokemonsView();

  @override
  _PokemonsViewState createState() => _PokemonsViewState();
}

class _PokemonsViewState extends ConsumerState<_PokemonsView> {
  void infiniteScroll() {
    final currentPokemons = ref.read(pokemonsIDProvider);
    if (currentPokemons.length > 400) {
      scrollController.removeListener(() {
        infiniteScroll();
      });
    }

    if ((scrollController.position.pixels + 200 > scrollController.position.maxScrollExtent)) {
      ref.read(pokemonsIDProvider.notifier).update((state) => [...state, ...List.generate(30, (index) => state.length + index + 1)]);
    }
  }

  @override
  void initState() {
    scrollController.addListener(() {
      infiniteScroll();
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          title: const Text('Pokemons'),
          floating: true,
          backgroundColor: Colors.white.withOpacity(0.8),
        ),
        const _PokemonGrid()
      ],
    );
  }
}

class _PokemonGrid extends ConsumerWidget {
  const _PokemonGrid({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final pokemonIDS = ref.watch(pokemonsIDProvider);
    return SliverGrid.builder(
        itemCount: pokemonIDS.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => context.push('/pokemons/${index + 1}'),
            child: Image.network(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/${index + 1}.png',
              fit: BoxFit.contain,
            ),
          );
        });
  }
}
