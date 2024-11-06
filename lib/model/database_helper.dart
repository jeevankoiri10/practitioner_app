import 'package:practitioner_app/model/offerings_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'offerings';

  static Future<Database> _getDatabase() async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'offerings_database.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id TEXT PRIMARY KEY,
            practitionerName TEXT,
            title TEXT,
            description TEXT,
            category TEXT,
            duration INTEGER,
            type TEXT,
            price REAL
          )
        ''');
      },
      version: 1,
    );
    return _database!;
  }

  Future<void> insertOffering(Offering offering) async {
    final db = await _getDatabase();
    await db.insert(
      tableName,
      offering.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateOffering(Offering offering) async {
    final db = await _getDatabase();
    await db.update(
      tableName,
      offering.toJson(),
      where: 'id = ?',
      whereArgs: [offering.id],
    );
  }

  // Fix fetchOfferings to return a List<Offering>
  Future<List<Offering>> fetchOfferings() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return Offering.fromJson(maps[i]);
    });
  }

  Future<void> deleteOffering(String id) async {
    final db = await _getDatabase();
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
