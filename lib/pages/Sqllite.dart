import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class datalite {
  static const _dbName = 'inventory.db';
  static const _dbVersion = 1;
  static const _tableName = 'inventory';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY,
        name TEXT,
        quantity INTEGER
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getInventory() async {
    final db = await database;
    return await db.query(_tableName);
  }

  Future<int> insertItem(Map<String, dynamic> item) async {
    final db = await database;
    return await db.insert(_tableName, item);
  }
}
