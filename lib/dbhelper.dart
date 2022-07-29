import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class databaseHelper {
  static final _databaseName = "person.db";
  static final _databaseVersion = 1;

  static final table = "person_data";

  static final columnId = "id";
  static final columnName = "name";
  static final columnAge = "age";

  static Database _database;

  databaseHelper._privateConstructor();
  static final databaseHelper instance = databaseHelper._privateConstructor();

  Future<Database> get databse async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory doucumentDirectory = await getApplicationDocumentsDirectory();
    String path = join(doucumentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table(
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnAge INTEGER NOT NULL
        )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.databse;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.databse;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryspecific(int age) async {
    Database db = await instance.databse;
    var res = await db.query(table, where: "age <?", whereArgs: [age]);

    // var res = await db.rawQuery('SELECT * FROM table WHERE age >?', [age]);
    return res;
  }

  Future<int> delete(int id) async {
    Database db = await instance.databse;

    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }
}
