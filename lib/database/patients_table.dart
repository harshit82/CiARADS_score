import 'package:CiARADS/database/database_export.dart';
import 'package:CiARADS/model/patient.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class PatientDB {
  Future<void> createTable(sql.Database database) async {
    await database.execute("""
          CREATE TABLE $tableName(
          $patientId TEXT NOT NULL PRIMARY KEY, 
          $patientName TEXT NOT NULL, 
          $patientAge INTEGER NOT NULL, 
          $doctorName TEXT NOT NULL, 
          $hospitalName TEXT NOT NULL,
          $marginAndSurface INTEGER,
          $vessel INTEGER,
          $lesionSize INTEGER,
          $aceticAcid INTEGER,
          $lugolIodine INTEGER,
          $totalScore INTEGER,
          $biopsyTaken TEXT,
          $histopathologyReport TEXT,
          $lugolIodineImagesPath TEXT,
          $greenFilterImagesPath TEXT,
          $normalSalineImagesPath TEXT,
          $aceticAcidImagesPath TEXT
          )
          """);

    Fluttertoast.showToast(msg: "Creating table: $tableName");
  }

  Future<void> deleteTable() async {
    final database = await DatabaseService().database;
    Fluttertoast.showToast(msg: "Deleting table: $tableName");
    await database.delete(tableName);
  }

  Future<int> addPatientData(
      {required Map<String, dynamic> patientData}) async {
    final database = await DatabaseService().database;
    Fluttertoast.showToast(msg: "Adding patient data");
    return await database.insert(tableName, patientData);
  }

  Future<int> addDiagnosisData(
      {required String patientId,
      required Map<String, dynamic> diagnosisData}) async {
    final database = await DatabaseService().database;
    Fluttertoast.showToast(msg: "Adding diagnosis data");
    return await database.insert(tableName, diagnosisData);
  }

  Future<void> removePatientData({required String patientId}) async {
    final database = await DatabaseService().database;
    Fluttertoast.showToast(msg: "Removing patient data");
    return database.execute("""
      DELETE FROM $tableName WHERE $primaryKey = $patientId
    """);
  }

  Future<int> updatePatientData(
      {required String patientId,
      required Map<String, dynamic> updatedData}) async {
    final database = await DatabaseService().database;
    Fluttertoast.showToast(msg: "Updating patient data");
    return await database.update(
      tableName,
      updatedData,
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  static getPatientData({required String patientId}) async {
    final database = await DatabaseService().database;
    List<Map<String, dynamic>> patient = await database.rawQuery("""
    SELECT * FROM $tableName WHERE $primaryKey = $patientId
    """);

    return List.generate(
        patient.length, (index) => Patient.fromMap(patient[index]));
  }

  static getAllPatientData() async {
    final database = await DatabaseService().database;

    List<Map<String, dynamic>> allPatients = await database.rawQuery("""
    SELECT * FROM $tableName
    """);

    return List.generate(
        allPatients.length, (index) => Patient.fromMap(allPatients[index]));
  }
}
