// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Patient {
  final String patient_name;
  final String patient_id;
  final int patient_age;
  final String doctor_name;
  final String hospital_id;
  final String margin_and_surface;
  final String vessel;
  final String lesion_size;
  final String acetic_acid;
  final String lugol_iodine;
  final String total_score;
  final String biopsy_taken;
  final String histopathology_report;

  Patient({
    required this.patient_name,
    required this.patient_id,
    required this.patient_age,
    required this.doctor_name,
    required this.hospital_id,
    required this.margin_and_surface,
    required this.vessel,
    required this.lesion_size,
    required this.acetic_acid,
    required this.lugol_iodine,
    required this.total_score,
    required this.biopsy_taken,
    required this.histopathology_report,
  });

  Patient copyWith({
    String? patient_name,
    String? patient_id,
    int? patient_age,
    String? doctor_name,
    String? hospital_id,
    String? margin_and_surface,
    String? vessel,
    String? lesion_size,
    String? acetic_acid,
    String? lugol_iodine,
    String? total_score,
    String? biopsy_taken,
    String? histopathology_report,
  }) {
    return Patient(
      patient_name: patient_name ?? this.patient_name,
      patient_id: patient_id ?? this.patient_id,
      patient_age: patient_age ?? this.patient_age,
      doctor_name: doctor_name ?? this.doctor_name,
      hospital_id: hospital_id ?? this.hospital_id,
      margin_and_surface: margin_and_surface ?? this.margin_and_surface,
      vessel: vessel ?? this.vessel,
      lesion_size: lesion_size ?? this.lesion_size,
      acetic_acid: acetic_acid ?? this.acetic_acid,
      lugol_iodine: lugol_iodine ?? this.lugol_iodine,
      total_score: total_score ?? this.total_score,
      biopsy_taken: biopsy_taken ?? this.biopsy_taken,
      histopathology_report:
          histopathology_report ?? this.histopathology_report,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'patient_name': patient_name});
    result.addAll({'patient_id': patient_id});
    result.addAll({'patient_age': patient_age});
    result.addAll({'doctor_name': doctor_name});
    result.addAll({'hospital_id': hospital_id});
    result.addAll({'margin_and_surface': margin_and_surface});
    result.addAll({'vessel': vessel});
    result.addAll({'lesion_size': lesion_size});
    result.addAll({'acetic_acid': acetic_acid});
    result.addAll({'lugol_iodine': lugol_iodine});
    result.addAll({'total_score': total_score});
    result.addAll({'biopsy_taken': biopsy_taken});
    result.addAll({'histopathology_report': histopathology_report});

    return result;
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      patient_name: map['patient_name'] ?? '',
      patient_id: map['patient_id'] ?? '',
      patient_age: map['patient_age']?.toInt() ?? 0,
      doctor_name: map['doctor_name'] ?? '',
      hospital_id: map['hospital_id'] ?? '',
      margin_and_surface: map['margin_and_surface'] ?? '',
      vessel: map['vessel'] ?? '',
      lesion_size: map['lesion_size'] ?? '',
      acetic_acid: map['acetic_acid'] ?? '',
      lugol_iodine: map['lugol_iodine'] ?? '',
      total_score: map['total_score'] ?? '',
      biopsy_taken: map['biopsy_taken'] ?? '',
      histopathology_report: map['histopathology_report'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Patient(patient_name: $patient_name, patient_id: $patient_id, patient_age: $patient_age, doctor_name: $doctor_name, hospital_id: $hospital_id, margin_and_surface: $margin_and_surface, vessel: $vessel, lesion_size: $lesion_size, acetic_acid: $acetic_acid, lugol_iodine: $lugol_iodine, total_score: $total_score, biopsy_taken: $biopsy_taken, histopathology_report: $histopathology_report)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Patient &&
        other.patient_name == patient_name &&
        other.patient_id == patient_id &&
        other.patient_age == patient_age &&
        other.doctor_name == doctor_name &&
        other.hospital_id == hospital_id &&
        other.margin_and_surface == margin_and_surface &&
        other.vessel == vessel &&
        other.lesion_size == lesion_size &&
        other.acetic_acid == acetic_acid &&
        other.lugol_iodine == lugol_iodine &&
        other.total_score == total_score &&
        other.biopsy_taken == biopsy_taken &&
        other.histopathology_report == histopathology_report;
  }

  @override
  int get hashCode {
    return patient_name.hashCode ^
        patient_id.hashCode ^
        patient_age.hashCode ^
        doctor_name.hashCode ^
        hospital_id.hashCode ^
        margin_and_surface.hashCode ^
        vessel.hashCode ^
        lesion_size.hashCode ^
        acetic_acid.hashCode ^
        lugol_iodine.hashCode ^
        total_score.hashCode ^
        biopsy_taken.hashCode ^
        histopathology_report.hashCode;
  }
}
