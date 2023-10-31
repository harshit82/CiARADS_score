import 'package:CiARADS/database/database_export.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class PatientDB {
  Future<void> createTable(sql.Database database) async {
    try {
      await database.execute("""
          CREATE TABLE $tableName(
          $patientId TEXT PRIMARY KEY, 
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
      database.close();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> deleteTable() async {
    try {
      final database = await DatabaseService().database;
      await database.delete(tableName);
      await database.close();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> addPatientData(
      {required Map<String, dynamic> patientData}) async {
    try {
      final database = await DatabaseService().database;
      await database.insert(tableName, patientData);
      await database.close();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> addDiagnosisData(
      {required String patientId,
      required Map<String, dynamic> diagnosisData}) async {
    try {
      final database = await DatabaseService().database;
      await database.update(tableName, diagnosisData);
      await database.close();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> removePatientData({required String patientId}) async {
    try {
      final database = await DatabaseService().database;
      await database.execute("""
      DELETE FROM $tableName WHERE $primaryKey = $patientId
    """);
      await database.close();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> updatePatientData(
      {required String patientId,
      required Map<String, dynamic> updatedData}) async {
    try {
      final database = await DatabaseService().database;
      Fluttertoast.showToast(msg: "Updating patient data");
      await database.update(
        tableName,
        updatedData,
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );
      await database.close();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<List<Map<String, dynamic>>?> getPatientData(
      {required String patientId}) async {
    try {
      final database = await DatabaseService().database;
      List<Map<String, dynamic>> patientData = await database
          .rawQuery("SELECT * FROM $tableName WHERE $primaryKey = $patientId");
      if (kDebugMode) {
        print(patientData);
      }
      //await database.close();
      return patientData;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  static Future<List<Map<String, dynamic>>?> getAllPatientData() async {
    try {
      final database = await DatabaseService().database;
      List<Map<String, dynamic>> allPatients =
          await database.rawQuery("SELECT * FROM $tableName");
      if (kDebugMode) {
        print(allPatients);
      }
      //await database.close();
      return allPatients;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}
