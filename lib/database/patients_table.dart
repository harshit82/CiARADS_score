import 'package:CiARADS/database/database_export.dart';
import 'package:CiARADS/model/patient.dart';
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
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static getPatientData({required String patientId}) async {
    try {
      final database = await DatabaseService().database;
      List<Map<String, dynamic>> patientData = await database.rawQuery("""
    SELECT * FROM $tableName WHERE $primaryKey = $patientId
    """);
      if (kDebugMode) {
        print(patientData);
      }
      return patientData;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future getAllPatientData() async {
    try {
      final database = await DatabaseService().database;
      List<Map<String, dynamic>> allPatients = await database.rawQuery("""
    SELECT * FROM $tableName
    """);
      return List.generate(
          allPatients.length, (index) => Patient.fromMap(allPatients[index]));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
