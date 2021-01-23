import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  /// opening or creating the database
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, "spaces.db"),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_spaces(id TEXT PRIMARY KEY,title TEXT, image TEXT)');
    }, version: 1);
  }

  /// insert a table into database
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  /// get the table from database
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
