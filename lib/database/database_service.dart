import 'package:calposcopy/database/patient_db.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseService {
  sql.Database? _database;

  Future<sql.Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const String name = 'patient.db';
    final String path = await sql.getDatabasesPath();
    //return join(path, name);
    return "$path$name";
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
}
