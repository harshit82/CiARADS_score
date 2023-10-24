import 'dart:convert';

class Diagnosis {
  final String marginAndSurface;
  final String vessel;
  final String lesionSize;
  final String aceticAcid;
  final String lugolIodine;
  final String totalScore;
  final String biopsyTaken;
  final String histopathologyReport;

  Diagnosis({
    required this.marginAndSurface,
    required this.vessel,
    required this.lesionSize,
    required this.aceticAcid,
    required this.lugolIodine,
    required this.totalScore,
    required this.biopsyTaken,
    required this.histopathologyReport,
  });

  Diagnosis copyWith({
    String? marginAndSurface,
    String? vessel,
    String? lesionSize,
    String? aceticAcid,
    String? lugolIodine,
    String? totalScore,
    String? biopsyTaken,
    String? histopathologyReport,
  }) {
    return Diagnosis(
      marginAndSurface: marginAndSurface ?? this.marginAndSurface,
      vessel: vessel ?? this.vessel,
      lesionSize: lesionSize ?? this.lesionSize,
      aceticAcid: aceticAcid ?? this.aceticAcid,
      lugolIodine: lugolIodine ?? this.lugolIodine,
      totalScore: totalScore ?? this.totalScore,
      biopsyTaken: biopsyTaken ?? this.biopsyTaken,
      histopathologyReport: histopathologyReport ?? this.histopathologyReport,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'marginAndSurface': marginAndSurface});
    result.addAll({'vessel': vessel});
    result.addAll({'lesionSize': lesionSize});
    result.addAll({'aceticAcid': aceticAcid});
    result.addAll({'lugolIodine': lugolIodine});
    result.addAll({'totalScore': totalScore});
    result.addAll({'biopsyTaken': biopsyTaken});
    result.addAll({'histopathologyReport': histopathologyReport});

    return result;
  }

  factory Diagnosis.fromMap(Map<String, dynamic> map) {
    return Diagnosis(
      marginAndSurface: map['marginAndSurface'] ?? '',
      vessel: map['vessel'] ?? '',
      lesionSize: map['lesionSize'] ?? '',
      aceticAcid: map['aceticAcid'] ?? '',
      lugolIodine: map['lugolIodine'] ?? '',
      totalScore: map['totalScore'] ?? '',
      biopsyTaken: map['biopsyTaken'] ?? '',
      histopathologyReport: map['histopathologyReport'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Diagnosis.fromJson(String source) =>
      Diagnosis.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Diagnosis(marginAndSurface: $marginAndSurface, vessel: $vessel, lesionSize: $lesionSize, aceticAcid: $aceticAcid, lugolIodine: $lugolIodine, totalScore: $totalScore, biopsyTaken: $biopsyTaken, histopathologyReport: $histopathologyReport)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Diagnosis &&
        other.marginAndSurface == marginAndSurface &&
        other.vessel == vessel &&
        other.lesionSize == lesionSize &&
        other.aceticAcid == aceticAcid &&
        other.lugolIodine == lugolIodine &&
        other.totalScore == totalScore &&
        other.biopsyTaken == biopsyTaken &&
        other.histopathologyReport == histopathologyReport;
  }

  @override
  int get hashCode {
    return marginAndSurface.hashCode ^
        vessel.hashCode ^
        lesionSize.hashCode ^
        aceticAcid.hashCode ^
        lugolIodine.hashCode ^
        totalScore.hashCode ^
        biopsyTaken.hashCode ^
        histopathologyReport.hashCode;
  }
}
