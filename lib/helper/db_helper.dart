import 'package:place_picker/models/place.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static const USER_PLACE_TABLE_NAME = 'user_places';
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    final placeDbPath = path.join(dbPath, 'places.db');
    return sql.openDatabase(
      placeDbPath,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $USER_PLACE_TABLE_NAME(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final placeDb = await DBHelper.database();
    await placeDb.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object>>> getData(
    String table,
    // {String id}
  ) async {
    final placeDb = await DBHelper.database();
    return placeDb.query(table, /*where: id != null ? 'WHERE id=$id' : ''*/);
  }
}
