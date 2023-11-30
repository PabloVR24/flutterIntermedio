import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/location/map_controller_provider.dart';
import 'package:miscelaneos/presentation/providers/location/user_location_provider.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userInitialLocation = ref.watch(userLocationProvider);

    return Scaffold(
      body: userInitialLocation.when(
          data: (data) => MapAndControlls(latitude: data.$1, longitude: data.$2),
          error: (error, stackTrance) => Text('$error'),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}

class MapAndControlls extends ConsumerWidget {
  final double latitude;
  final double longitude;
  const MapAndControlls({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context, ref) {
    final mapControllerState = ref.watch(mapControllerProvider);
    return Stack(
      children: [
        _MapView(initialLat: latitude, initialLong: longitude),
        //! BACKBUTTON
        Positioned(
            top: 40,
            left: 20,
            child: IconButton.filledTonal(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back),
            )),
        //! POSICION USUARIO
        Positioned(
            bottom: 40,
            left: 20,
            child: IconButton.filledTonal(
              onPressed: () {
                ref.read(mapControllerProvider.notifier).findUser();
              },
              icon: const Icon(Icons.location_searching),
            )),
        //! SEGUIR AL USUARIO
        Positioned(
            bottom: 90,
            left: 20,
            child: IconButton.filledTonal(
              onPressed: () {
                ref.read(mapControllerProvider.notifier).toggleFollowUser();
              },
              icon: Icon(mapControllerState.followUser ? Icons.directions_run : Icons.accessibility_new), //icon: const Icon(Icons.directions_run),
            )),
        //! CREAR MARCADOR
        Positioned(
            bottom: 140,
            left: 20,
            child: IconButton.filledTonal(
              onPressed: () {
                ref.read(mapControllerProvider.notifier).addMarkerCurrentPosition();
              },
              icon: const Icon(Icons.pin_drop),
            )),
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  final double initialLat;
  final double initialLong;
  const _MapView({super.key, required this.initialLat, required this.initialLong});

  @override
  __MapViewState createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {
    final mapController = ref.watch(mapControllerProvider);

    return GoogleMap(
      markers: mapController.markersSet,
      mapType: MapType.normal,
      onLongPress: (args){
       ref.read(mapControllerProvider.notifier).addMarker(args.latitude, args.longitude, 'Custom');
      },
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(target: LatLng(widget.initialLat, widget.initialLong), zoom: 12),
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapControllerProvider.notifier).setMapController(controller);
      },
    );
  }
}
