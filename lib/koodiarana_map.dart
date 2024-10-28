import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class KoodiaranaMap extends StatefulWidget {
  Function manageDeplacement;
  KoodiaranaMap({super.key, required this.manageDeplacement});

  @override
  State<KoodiaranaMap> createState() => _KoodiaranaMapState();
}

class _KoodiaranaMapState extends State<KoodiaranaMap>
    with TickerProviderStateMixin {
  bool toogle = false;
  LatLng? _currentPosition;
  LatLng? futurePosition;
  List<LatLng> routes = [];
  String? description;
  bool? goNow;
  final String tokens =
      '5b3ce3597851110001cf62485775a9d2e27048c9a7c9ab5cfbf3ee05';
  late final _animatedMapController = AnimatedMapController(vsync: this);
  String valueToGo = 'Maintenant';
  Marker? marker;
  List<ConnectivityResult>? connectivityResult = [ConnectivityResult.none];

  void newMarker(LatLng latLng) {
    futurePosition = latLng;
    setState(() {
      marker = Marker(
          point: latLng,
          child: const Icon(
            Icons.place,
            color: Colors.black,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _animatedMapController.mapController,
      options: MapOptions(
        initialCenter: _currentPosition!,
        initialZoom: 15,
        onTap: (position, latLng) async {
          final latitudeDestination = latLng.latitude;
          final longitudeDestination = latLng.longitude;
          final latitudeLocalisation = _currentPosition!.latitude;
          final longitudeLocalisation = _currentPosition!.longitude;
          newMarker(latLng);
          final responseDestination = await http.get(Uri.parse(
              'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitudeDestination&lon=$longitudeDestination'));
          final responseLocalisation = await http.get(Uri.parse(
              'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitudeLocalisation&lon=$longitudeLocalisation'));
          final uriRoutes = await http.get(
            Uri.parse(
                'https://api.openrouteservice.org/v2/directions/driving-car?start=${_currentPosition!.longitude},${_currentPosition!.latitude}&end=${latLng.longitude},${latLng.latitude}'),
            headers: {
              'Authorization': tokens,
              'Content-Type': 'application/json',
            },
          );

          if (uriRoutes.statusCode == 200) {
            final feature = jsonDecode(uriRoutes.body);
            // Accès correct aux coordonnées de la route
            final data = feature['features'][0];
            final List<dynamic> coordinates = data['geometry']['coordinates'];

            setState(
              () {
                routes = coordinates
                    .map((coord) => LatLng(coord[1], coord[0]))
                    .toList();
              },
            );
          }
          if (responseDestination.statusCode == 200 &&
              responseLocalisation.statusCode == 200) {
            final dataDestination = jsonDecode(responseDestination.body);
            final dataLocalisation = jsonDecode(responseLocalisation.body);
            // manageDeplacement(latLng, dataDestination, dataLocalisation,
            //     'Maintenant', toogle);
            widget.manageDeplacement(latLng, dataDestination, dataLocalisation,
                'Maintenant', toogle);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Verifiez votre connexion Internet'),
              duration: Duration(seconds: 3),
            ));
          }
        },
      ),
      children: [
        TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
            subdomains: const ['a', 'b', 'c'],
            tileProvider: NetworkTileProvider()),
        MarkerLayer(
          markers: marker != null ? [marker!] : [],
        ),
        AnimatedMarkerLayer(
          markers: [
            AnimatedMarker(
              point: _currentPosition!,
              builder: (_, animation) {
                final size = 30.0 * animation.value;
                return Icon(
                  Icons.location_on,
                  size: size,
                  color: Colors.red,
                );
              },
            ),
          ],
        ),
        futurePosition != null
            ? PolylineLayer(
                polylines: [
                  Polyline(
                    points: routes, // [_currentPosition!, futurePosition!],
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  ),
                ],
              )
            : PolylineLayer(
                polylines: [
                  Polyline(
                    points: [_currentPosition!, _currentPosition!],
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  ),
                ],
              )
      ],
    );
  }
}
