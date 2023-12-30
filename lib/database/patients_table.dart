import 'dart:collection';
import 'package:CiARADS/database/database_export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class PatientTable {
  static final token = RootIsolateToken.instance;
  static Future<void> createTable(Database database) async {
    try {
      await database.execute("""
          DROP TABLE IF EXISTS $tableName;
        """);
      await database.execute("""
          CREATE TABLE IF NOT EXISTS $tableName(
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
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<void> deleteTable() async {
    try {
      await compute((dynamic token) async {
        BackgroundIsolateBinaryMessenger.ensureInitialized(token);
        final database = await DatabaseService().database;
        await database.delete(tableName);
      }, token);

      Fluttertoast.showToast(msg: "Deleting table: $tableName");
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<void> addPatientData(
      {required Map<String, dynamic> patientData}) async {
    try {
      await compute((dynamic token) async {
        BackgroundIsolateBinaryMessenger.ensureInitialized(token);
        final database = await DatabaseService().database;
        await database.insert(tableName, patientData);
      }, token);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<void> addDiagnosisData(
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
      await compute((dynamic token) async {
        BackgroundIsolateBinaryMessenger.ensureInitialized(token);
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
      }, token);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<void> addImagesPaths(
      {required String patientId,
      required Map<String, dynamic> imagePaths}) async {
    // Sorting the keys and the corresponding data in ascending order
    var sortedByKeyMap = SplayTreeMap<String, dynamic>.from(
        imagePaths, ((key1, key2) => key1.compareTo(key2)));

    List<String> paths = [];
    sortedByKeyMap.forEach((key, value) {
      paths.add(value);
    });

    if (kDebugMode) {
      print("Image paths to be added = ");
      print(paths);
    }

    try {
      await compute((dynamic token) async {
        BackgroundIsolateBinaryMessenger.ensureInitialized(token);
        final database = await DatabaseService().database;
        await database.rawUpdate("""
        UPDATE $tableName SET
        $aceticAcidImagesPath = ?,
        $greenFilterImagesPath = ?,
        $lugolIodineImagesPath = ?,
        $normalSalineImagesPath = ?
        WHERE $primaryKey = '$patientId'
        """, paths);
      }, token);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  /// @dev returns the table structure in debug mode terminal
  static Future<void> seeTable() async {
    await compute((dynamic token) async {
      BackgroundIsolateBinaryMessenger.ensureInitialized(token);
      final database = await DatabaseService().database;
      var table = await database.rawQuery("PRAGMA table_info($tableName)");
      if (kDebugMode) {
        print(table);
      }
    }, token);
  }

  static Future<void> removePatientData({required String patientId}) async {
    try {
      await compute((dynamic token) async {
        BackgroundIsolateBinaryMessenger.ensureInitialized(token);
        final database = await DatabaseService().database;
        await database.rawQuery("""
      DELETE FROM $tableName WHERE $primaryKey = '$patientId'
      """);
      }, token);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<void> updatePatientData(
      {required String patientId,
      required Map<String, dynamic> updatedData}) async {
    try {
      await compute((dynamic token) async {
        BackgroundIsolateBinaryMessenger.ensureInitialized(token);
        final database = await DatabaseService().database;
        await database.update(
          tableName,
          updatedData,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }, token);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<Map<String, dynamic>> getPatientData(
      {required String patientId}) async {
    final database = await DatabaseService().database;
    List<Map<String, dynamic>> patientData = await database.rawQuery("""
      SELECT * FROM $tableName WHERE $primaryKey = '$patientId' 
    """);
    if (kDebugMode) {
      print(patientData);
    }
    if (patientData.isNotEmpty) {
      return patientData.first;
    }
    return {};
  }

  static Future<List<Map<String, dynamic>>> getAllPatientData() async {
    final database = await DatabaseService().database;
    List<Map<String, dynamic>> allPatients = await database.rawQuery("""
          SELECT * FROM $tableName
        """);
    if (kDebugMode) {
      print(allPatients);
    }
    return allPatients;
  }
}
