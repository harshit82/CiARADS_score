import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:CiARADS/database/database_export.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseService {
  DatabaseService._privateConstructor();
  static final DatabaseService _instance =
      DatabaseService._privateConstructor();
  static sql.Database? _database;

  Future<sql.Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  factory DatabaseService() {
    return _instance;
  }

  Future<String> get fullPath async {
    final Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, databaseName);
    return path;
  }

  Future<sql.Database> _initialize() async {
    final path = await fullPath;
    var database = await sql.openDatabase(path,
        version: 1, onCreate: createDB, singleInstance: true);
    return database;
  }

  Future<void> createDB(sql.Database database, int version) async {
    await PatientDB().createTable(database);
  }

  Future<void> deleteDB(String databasePath) async {
    await sql.deleteDatabase(databasePath);
  }

  Future<void> saveImage(String base64Image) async {
    final path = await fullPath;
    sql.Database db = await sql.openDatabase(path);
    await db.transaction((txn) async {
      await txn.rawInsert('INSERT INTO $tableName VALUES (?)', [base64Image]);
    });
    await db.close();
  }

  Future<Uint8List> loadImage(String image) async {
    final path = await fullPath;
    sql.Database db = await sql.openDatabase(path);
    List<Map<String, dynamic>> rows =
        await db.rawQuery('SELECT $image FROM $tableName');
    String base64Image = rows[0][image];
    await db.close();
    return base64Decode(base64Image);
  }
}
