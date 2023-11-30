import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:miscelaneos/presentation/providers/ads/admob_providers.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem(this.title, this.icon, this.route);
}

final menuItems = [
  MenuItem('Giroscopio', Icons.downloading, '/giroscope'),
  MenuItem('Acelerometro', Icons.speed, '/accelerometer'),
  MenuItem('Magnetometro', Icons.explore_outlined, '/magnetometter'),
  MenuItem('Giroscopio Ball', Icons.sports_baseball_outlined, '/giroscope-ball'),
  MenuItem('Brujula', Icons.explore, '/compass'),
  MenuItem('Pokemons', Icons.catching_pokemon, '/pokemons'),
  MenuItem('Background Process', Icons.storage_rounded, '/db-pokemons'),
  MenuItem('Biometricos', Icons.fingerprint, '/biometrics'),
  MenuItem('Ubicacion', Icons.pin_drop, '/location'),
  MenuItem('Mapas', Icons.map_outlined, '/maps'),
  MenuItem('Control', Icons.gamepad_outlined, '/controlled-map'),
  MenuItem('Badge', Icons.notification_add, '/badge'),
  MenuItem('Ad Full', Icons.ad_units_outlined, '/ad-fullscreen'),
  MenuItem('Ad Rewarded', Icons.ad_units_sharp, '/ad-rewarded'),
];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final adBannerAsync = ref.watch(adBannerProvider);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: const Text('Miscelaneos'),
                    actions: [IconButton(onPressed: () => context.push('/permissions'), icon: const Icon(Icons.settings))],
                  ),
                  const _HomeScreenView()
                ],
              ),
            ),
          ),
          adBannerAsync.when(
              data: (data) => SizedBox(
                    width: data.size.width.toDouble(),
                    height: data.size.height.toDouble(),
                    child: AdWidget(ad: data),
                  ),
              error: (_, __) => const SizedBox(),
              loading: () => const SizedBox())
        ],
      ),
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView();

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: menuItems.map((item) => HomeMenuItem(title: item.title, icon: item.icon, route: item.route)).toList());
  }
}

class HomeMenuItem extends StatelessWidget {
  const HomeMenuItem(
      {super.key, required this.title, required this.icon, required this.route, this.bgColors = const [Colors.lightBlue, Colors.blue]});
  final String title;
  final IconData icon;
  final String route;
  final List<Color> bgColors;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: bgColors, begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          )
        ]),
      ),
    );
  }
}
