import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/location/user_location_provider.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentPositionAsync = ref.watch(userLocationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Controlled Map Screen'),
      ),
      body: currentPositionAsync.when(
          data: (data) => _MapView(initialLat: data.$1, initialLong: data.$2),
          error: (error, stackTrance) => Text('$error'),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}

class _MapView extends StatefulWidget {
  final double initialLat;
  final double initialLong;
  const _MapView({super.key, required this.initialLat, required this.initialLong});

  @override
  State<_MapView> createState() => __MapViewState();
}

class __MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(target: LatLng(widget.initialLat, widget.initialLong), zoom: 12),
      onMapCreated: (GoogleMapController controller) {},
    );
  }
}
