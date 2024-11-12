import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Importa flutter_map
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart'; // Importa la librería para trabajar con coordenadas
import '../models/db_helper.dart';
import '../config/permissions/permissions_provider.dart';
import '../providers/user_location_provider.dart'; // Asegúrate de importar el provider de ubicación

class Road extends ConsumerStatefulWidget {
  const Road({super.key});

  @override
  _RoadState createState() => _RoadState();
}

class _RoadState extends ConsumerState<Road> {
  final List<LatLng> _route = []; // Lista de puntos para la ruta
  LatLng? _currentPosition; // Ubicación actual del usuario

  // Función para obtener la ubicación en tiempo real usando Geolocator
  Future<void> _getLocation() async {
    final permissionState = ref.read(permissionsProvider);

    // Verificamos si los permisos de ubicación han sido otorgados
    if (!permissionState.locationGranted) {
      await ref.read(permissionsProvider.notifier).requestLocationAccess();
    }

    if (permissionState.locationGranted) {
      // Obtener la ubicación en tiempo real
      // Aquí podrías utilizar el provider de ubicación para gestionar la ubicación en tiempo real.
    } else {
      print("Los permisos de ubicación no están concedidos");
    }
  }

  // Actualizar la ubicación y guardar en la base de datos
  void _updateLocation(LatLng position) async {
    // Agregar la nueva ubicación a la ruta
    _route.add(position);

    // Guardar la ubicación en la base de datos
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
    _getLocation(); // Obtiene la ubicación inicial
  }

  @override
  Widget build(BuildContext context) {
    // Escuchamos el estado del provider de ubicación
    final userLocationAsync = ref.watch(userLocationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Rutas de Ejercicio")),
      body: userLocationAsync.when(
        data: (data) {
          // Asegúrate de que 'data' contiene los valores de latitud y longitud
          final currentLatLng = LatLng(data.$1, data.$2);

          // Actualizamos la posición actual y la ruta
          _updateLocation(currentLatLng);

          return FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
              5.7110, -73.0721), // Reemplaza 'center' por 'initialCenter'
          initialZoom: 14.0, // Reemplaza 'zoom' por 'initialZoom'
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
                  // Agregar los marcadores de la ruta
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
                    points: _route, // Lista de coordenadas
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
