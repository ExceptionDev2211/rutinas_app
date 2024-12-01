import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class RouteRoad {
  final int? id;
  final double latitude;
  final double longitude;
  final String timestamp;

  RouteRoad({this.id, required this.latitude, required this.longitude, required this.timestamp});

  
  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    };
  }

  
  static RouteRoad fromMap(Map<String, dynamic> map) {
    return RouteRoad(
      id: map['id'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      timestamp: map['timestamp'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('exercise_routes.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final fullPath = join(dbPath, path);

    return await openDatabase(
      fullPath,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE routes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            latitude REAL,
            longitude REAL,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  
  Future<int> insertRoute(RouteRoad route) async {
    final db = await instance.database;
    return await db.insert('routes', route.toMap());
  }

  
  Future<List<RouteRoad>> getRoutes() async {
    final db = await instance.database;
    final result = await db.query('routes');

    return result.map((map) => RouteRoad.fromMap(map)).toList();
  }
}
