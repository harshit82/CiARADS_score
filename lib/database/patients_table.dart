import 'package:CiARADS/database/database_export.dart';
import 'package:CiARADS/views/views_export.dart';
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
      ErrorWidget(errorMessage: e.toString());
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
      ErrorWidget(errorMessage: e.toString());
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
      ErrorWidget(errorMessage: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> addDiagnosisData(
      {required String patientId,
      required Map<String, dynamic> diagnosisData}) async {
    List<dynamic> dataList = [];
    diagnosisData.forEach((key, value) {
      dataList.add(value);
    });
    if (kDebugMode) {
      print("Diagnostic data to be added = ");
      print(dataList);
    }
    try {
      final database = await DatabaseService().database;
      await database.rawUpdate("""
        UPDATE $tableName SET
        $marginAndSurface = ?,
        $vessel = ?,
        $lesionSize = ?,
        $aceticAcid = ?,
        $lugolIodine = ?,
        $totalScore = ?,
        $biopsyTaken = ?,
        $histopathologyReport = ?
        WHERE $primaryKey = '$patientId' 
        """, dataList);
    } catch (e) {
      ErrorWidget(errorMessage: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> addImagesPaths(
      {required String patientId,
      required Map<String, dynamic> imagePaths}) async {
    List<String> paths = [];
    imagePaths.forEach((key, value) {
      paths.add(value);
    });

    if (kDebugMode) {
      print("Image paths to be added = ");
      print(paths);
    }

    try {
      final database = await DatabaseService().database;
      await database.rawUpdate("""
        UPDATE $tableName SET
        $lugolIodineImagesPath = ?,
        $greenFilterImagesPath = ?,
        $normalSalineImagesPath = ?,
        $aceticAcidImagesPath = ?
        WHERE $primaryKey = '$patientId' 
      """);
    } catch (e) {
      ErrorWidget(errorMessage: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> seeTable() async {
    final database = await DatabaseService().database;
    var table = await database.rawQuery("SELECT * FROM $tableName");
    if (kDebugMode) {
      print(table);
    }
  }

  Future<void> removePatientData({required String patientId}) async {
    try {
      final database = await DatabaseService().database;
      await database.execute("""
      DELETE FROM $tableName WHERE $primaryKey = '$patientId'
      DELETE FROM $tableName WHERE $primaryKey = '$patientId'
      """);
    } catch (e) {
      ErrorWidget(errorMessage: e.toString());
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
      await database.update(
        tableName,
        updatedData,
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );
    } catch (e) {
      ErrorWidget(errorMessage: e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<List<Map<String, dynamic>>> getPatientData(
      {required String patientId}) async {
    final database = await DatabaseService().database;
    List<Map<String, dynamic>> patientData = await database
        .rawQuery("SELECT * FROM $tableName WHERE $primaryKey = '$patientId' ");
    if (kDebugMode) {
      print(patientData);
    }
    return patientData;
  }

  static Future<List<Map<String, dynamic>>> getAllPatientData() async {
    final database = await DatabaseService().database;
    List<Map<String, dynamic>> allPatients =
        await database.rawQuery("SELECT * FROM $tableName");
    if (kDebugMode) {
      print(allPatients);
    }
    return allPatients;
  }
}
