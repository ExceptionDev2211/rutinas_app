import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../models/db_helper.dart';
import '../config/permissions/permissions_provider.dart';
import '../providers/user_location_provider.dart'; 

class Road extends ConsumerStatefulWidget {
  const Road({super.key});

  @override
  _RoadState createState() => _RoadState();
}

class _RoadState extends ConsumerState<Road> {
  final List<LatLng> _route = [];
  LatLng? _currentPosition; 

 
  Future<void> _getLocation() async {
    final permissionState = ref.read(permissionsProvider);

   
    if (!permissionState.locationGranted) {
      await ref.read(permissionsProvider.notifier).requestLocationAccess();
    }

    if (permissionState.locationGranted) {
     
    } else {
      print("Los permisos de ubicación no están concedidos");
    }
  }


  void _updateLocation(LatLng position) async {

    _route.add(position);

 
    RouteRoad route = RouteRoad(
      latitude: position.latitude,
      longitude: position.longitude,
      timestamp: DateTime.now().toIso8601String(),
    );

    await DatabaseHelper.instance.insertRoute(route);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getLocation(); 
  }

  @override
  Widget build(BuildContext context) {
   
    final userLocationAsync = ref.watch(userLocationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Rutas de Ejercicio")),
      body: userLocationAsync.when(
        data: (data) {
         
          final currentLatLng = LatLng(data.$1, data.$2);

       
          _updateLocation(currentLatLng);

          return FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
              5.7110, -73.0721), 
          initialZoom: 14.0, 
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: currentLatLng,
                    width: 40.0,
                    height: 40.0,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 40.0,
                    ),
                  ),
               
                  ..._route.map((latLng) {
                    return Marker(
                      point: latLng,
                      width: 40.0,
                      height: 40.0,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 40.0,
                      ),
                    );
                  }).toList(),
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _route,
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(
              'Error al obtener la ubicación: $error',
              style: const TextStyle(color: Colors.red),
            ),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
