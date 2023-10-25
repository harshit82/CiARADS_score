import 'package:calposcopy/constants.dart';
import 'package:calposcopy/database/database_service.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class PatientDB {
  Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName(
          patient_id TEXT NOT NULL PRIMARY KEY, 
          patient_name NOT NULL TEXT, 
          patient_age INTEGER, 
          doctor_name NOT NULL TEXT, 
          hospital_id NOT NULL TEXT,
          margin_and_surface TEXT,
          vessel TEXT,
          lesion_size TEXT,
          acetic_acid TEXT,
          lugol_iodine TEXT,
          total_score TEXT,
          biopsy_taken TEXT,
          histopathology_report TEXT
          )
          """);
  }

  Future<void> deleteTable() async {
    final database = await DatabaseService().database;
    database.delete(tableName);
  }

  Future<int> addPatientData(
      {required Map<String, dynamic> patientData}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert("""
    INSERT INTO $tableName (
      ${patientData['patient_id']},
      ${patientData['patient_name']},
      ${patientData['patient_age']},
      ${patientData['doctor_name']},
      ${patientData['hospital_id']},
    )
    """);
  }

  Future<int> addDiagnosisData(
      {required String patientId,
      required Map<String, dynamic> diagnosisData}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert("""  
    INSERT INTO $tableName (
      ${diagnosisData['margin_and_surface']},
      ${diagnosisData['vessel']},
      ${diagnosisData['lesion_size']},
      ${diagnosisData['acetic_acid']},
      ${diagnosisData['lugol_iodine']},
      ${diagnosisData['total_score']},
      ${diagnosisData['biopsy_taken']},
      ${diagnosisData['histopathology_report']},
    )
    """);
  }

  Future<void> removePatientData({required String patientId}) async {
    final database = await DatabaseService().database;
    return database.execute("""
      DELETE FROM $tableName WHERE $primaryKey = $patientId
    """);
  }

  Future<int> updatePatientData(
      {required String patientId,
      required Map<String, dynamic> updatedData}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      updatedData,
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  Future<List<Map<String, dynamic>>> getPatientData(
      {required String patientId}) async {
    final database = await DatabaseService().database;
    return await database.rawQuery("""
    SELECT * FROM $tableName WHERE $primaryKey = $patientId
    """);
  }

  Future<List<Map<String, dynamic>>> getAllPatientData() async {
    final database = await DatabaseService().database;
    return await database.rawQuery("""
    SELECT * FROM $tableName
    """);
  }
}
