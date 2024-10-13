import 'package:rutinas_app/models/db_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBEFeatures {
  static final DBEFeatures _instance = DBEFeatures._internal();
  static Database? _database;

  factory DBEFeatures() {
    return _instance;
  }

  DBEFeatures._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'routines.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE routines(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        type TEXT,
        difficulty TEXT
      )
    ''');
  }

  Future<int> insertRoutine(Routine routine) async {
    final db = await database;
    return await db.insert('routines', routine.toMap());
  }

  Future<List<Routine>> getAllRoutines() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('routines');

    return List.generate(maps.length, (i) {
      return Routine.fromMap(maps[i]);
    });
  }

  Future<List<Routine>> getRoutinesByTypeAndDifficulty(String type, String difficulty) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'routines',
      where: 'type = ? AND difficulty = ?',
      whereArgs: [type, difficulty],
    );

    return List.generate(maps.length, (i) {
      return Routine.fromMap(maps[i]);
    });
  }

  Future<int> updateRoutine(Routine routine) async {
    final db = await database;
    return await db.update(
      'routines',
      routine.toMap(),
      where: 'id = ?',
      whereArgs: [routine.id],
    );
  }

  Future<int> deleteRoutine(int id) async {
    final db = await database;
    return await db.delete(
      'routines',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
