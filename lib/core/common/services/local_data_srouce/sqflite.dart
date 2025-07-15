import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ego/app/get_it/get_it.dart';
import 'package:ego/core/common/services/local_data_srouce/table_schemas.dart';

abstract class SqfliteDatabase {
  Future<void> initialize();
  Future<int> insertItem(
      {required String tableName, required Map<String, dynamic> item});
  Future<List<Map<String, dynamic>>> getItems({required String tableName});
  Future<int> updateItem(
      {required String tableName,
      required int id,
      required Map<String, dynamic> updatedData});
  Future<Map<String, dynamic>?> getItem(
      {required String tableName, required int id});
  Future<int> deleteItem({required String tableName, required int id});
  Future<void> closeDB();
}

class SqfliteDatabaseImp implements SqfliteDatabase {
  static Database? _database;
  static final SqfliteDatabaseImp instance = SqfliteDatabaseImp._init();

  SqfliteDatabaseImp._init();

  @override
  Future<void> initialize() async {
    try {
      if (_database == null) {
        Database? db;
        db = await instance._initDB('tradervolt_database.db');
      }
    } catch (ex) {
      logger.e("Exception occured when initializing DB: ${ex.toString()}");
    }
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    return await _initDB('tradervolt_database.db');
  }

  Future<Database> _initDB(String name) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, name);
      _database = await openDatabase(
        path,
        version: 1,
        // onCreate: _createDB,
      );
      return _database!;
    } catch (e) {
      throw Exception("Error initializing database: $e");
    }
  }

  Future<void> _createDB(Database db, int version) async {
    for (var statement in tableSchemas.values) {
      await db.execute(statement);
    }
  }

  @override
  Future<int> insertItem({
    required String tableName,
    required Map<String, dynamic> item,
  }) async {
    final db = await database;
    return await db.insert(tableName, item);
  }

  @override
  Future<List<Map<String, dynamic>>> getItems(
      {required String tableName}) async {
    final db = await database;
    return await db.query(tableName);
  }

  @override
  Future<Map<String, dynamic>?> getItem({
    required String tableName,
    required dynamic id,
  }) async {
    final db = await database;
    final result = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty ? result.first : null;
  }

  @override
  Future<int> updateItem({
    required String tableName,
    required dynamic id,
    required Map<String, dynamic> updatedData,
  }) async {
    final db = await database;
    return await db.update(
      tableName,
      updatedData,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteItem({
    required String tableName,
    required dynamic id,
  }) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> closeDB() async {
    final db = await database;
    db.close();
  }
}
