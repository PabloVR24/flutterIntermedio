import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/screens/pokemons/db_pokemons.screen.dart';
import 'package:miscelaneos/presentation/screens/screens.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/permissions',
    builder: (context, state) => const PermisionsScreen(),
  ),
  GoRoute(
    path: '/giroscope',
    builder: (context, state) => const GiroscopeScreen(),
  ),
  GoRoute(
    path: '/accelerometer',
    builder: (context, state) => const AccelerometterScreen(),
  ),
  GoRoute(
    path: '/magnetometter',
    builder: (context, state) => const MagnetometterScreen(),
  ),
  GoRoute(
    path: '/giroscope-ball',
    builder: (context, state) => const GiroscopeBallScreen(),
  ),
  GoRoute(
    path: '/compass',
    builder: (context, state) => const CompassScreen(),
  ),
  GoRoute(path: '/pokemons', builder: (context, state) => const PokemonsScreen(), routes: [
    GoRoute(
        path: ':id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 1;
          return PokemonScreen(pokemonID: id as String);
        })
  ]),
  GoRoute(
    path: '/db-pokemons',
    builder: (context, state) => const DbPokemonsScrenn(),
  ),
  GoRoute(path: '/biometrics', builder: (context, state) => const BiometricScreen()),
  GoRoute(path: '/location', builder: (context, state) => const LocationScreen()),
  GoRoute(path: '/maps', builder: (context, state) => const MapScreen()),
  GoRoute(path: '/controlled-map', builder: (context, state) => const ControlledMapScreen()),
  GoRoute(path: '/badge', builder: (context, state) => const BadgeScreen()),
  GoRoute(path: '/ad-fullscreen', builder: (context, state) => const AdFullScreen()),
  GoRoute(path: '/ad-rewarded', builder: (context, state) => const AdRewarded())
]);
