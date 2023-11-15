// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Patient {
  final String? patient_name;
  final String? patient_id;
  final int? patient_age;
  final String? doctor_name;
  final String? hospital_name;
  final int? margin_and_surface;
  final int? vessel;
  final int? lesion_size;
  final int? acetic_acid;
  final int? lugol_iodine;
  final int? total_score;
  final String? biopsy_taken;
  final String? histopathology_report;
  final String? acetic_acid_img_path;
  final String? green_filter_img_path;
  final String? lugol_iodine_img_path;
  final String? normal_saline_img_path;

  Patient({
    required this.patient_name,
    required this.patient_id,
    required this.patient_age,
    required this.doctor_name,
    required this.hospital_name,
    required this.margin_and_surface,
    required this.vessel,
    required this.lesion_size,
    required this.acetic_acid,
    required this.lugol_iodine,
    required this.total_score,
    required this.biopsy_taken,
    required this.histopathology_report,
    required this.acetic_acid_img_path,
    required this.green_filter_img_path,
    required this.lugol_iodine_img_path,
    required this.normal_saline_img_path,
  });

  Patient copyWith({
    String? patient_name,
    String? patient_id,
    int? patient_age,
    String? doctor_name,
    String? hospital_name,
    int? margin_and_surface,
    int? vessel,
    int? lesion_size,
    int? acetic_acid,
    int? lugol_iodine,
    int? total_score,
    String? biopsy_taken,
    String? histopathology_report,
    String? acetic_acid_img_path,
    String? green_filter_img_path,
    String? lugol_iodine_img_path,
    String? normal_saline_img_path,
  }) {
    return Patient(
      patient_name: patient_name ?? this.patient_name,
      patient_id: patient_id ?? this.patient_id,
      patient_age: patient_age ?? this.patient_age,
      doctor_name: doctor_name ?? this.doctor_name,
      hospital_name: hospital_name ?? this.hospital_name,
      margin_and_surface: margin_and_surface ?? this.margin_and_surface,
      vessel: vessel ?? this.vessel,
      lesion_size: lesion_size ?? this.lesion_size,
      acetic_acid: acetic_acid ?? this.acetic_acid,
      lugol_iodine: lugol_iodine ?? this.lugol_iodine,
      total_score: total_score ?? this.total_score,
      biopsy_taken: biopsy_taken ?? this.biopsy_taken,
      histopathology_report:
          histopathology_report ?? this.histopathology_report,
      acetic_acid_img_path: acetic_acid_img_path ?? this.acetic_acid_img_path,
      green_filter_img_path:
          green_filter_img_path ?? this.green_filter_img_path,
      lugol_iodine_img_path:
          lugol_iodine_img_path ?? this.lugol_iodine_img_path,
      normal_saline_img_path:
          normal_saline_img_path ?? this.normal_saline_img_path,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (patient_name != null) {
      result.addAll({'patient_name': patient_name});
    }
    if (patient_id != null) {
      result.addAll({'patient_id': patient_id});
    }
    if (patient_age != null) {
      result.addAll({'patient_age': patient_age});
    }
    if (doctor_name != null) {
      result.addAll({'doctor_name': doctor_name});
    }
    if (hospital_name != null) {
      result.addAll({'hospital_name': hospital_name});
    }
    if (margin_and_surface != null) {
      result.addAll({'margin_and_surface': margin_and_surface});
    }
    if (vessel != null) {
      result.addAll({'vessel': vessel});
    }
    if (lesion_size != null) {
      result.addAll({'lesion_size': lesion_size});
    }
    if (acetic_acid != null) {
      result.addAll({'acetic_acid': acetic_acid});
    }
    if (lugol_iodine != null) {
      result.addAll({'lugol_iodine': lugol_iodine});
    }
    if (total_score != null) {
      result.addAll({'total_score': total_score});
    }
    if (biopsy_taken != null) {
      result.addAll({'biopsy_taken': biopsy_taken});
    }
    if (histopathology_report != null) {
      result.addAll({'histopathology_report': histopathology_report});
    }
    if (acetic_acid_img_path != null) {
      result.addAll({'acetic_acid_img_path': acetic_acid_img_path});
    }
    if (green_filter_img_path != null) {
      result.addAll({'green_filter_img_path': green_filter_img_path});
    }
    if (lugol_iodine_img_path != null) {
      result.addAll({'lugol_iodine_img_path': lugol_iodine_img_path});
    }
    if (normal_saline_img_path != null) {
      result.addAll({'normal_saline_img_path': normal_saline_img_path});
    }

    return result;
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      patient_name: map['patient_name'],
      patient_id: map['patient_id'],
      patient_age: map['patient_age']?.toInt(),
      doctor_name: map['doctor_name'],
      hospital_name: map['hospital_name'],
      margin_and_surface: map['margin_and_surface']?.toInt(),
      vessel: map['vessel']?.toInt(),
      lesion_size: map['lesion_size']?.toInt(),
      acetic_acid: map['acetic_acid']?.toInt(),
      lugol_iodine: map['lugol_iodine']?.toInt(),
      total_score: map['total_score']?.toInt(),
      biopsy_taken: map['biopsy_taken'],
      histopathology_report: map['histopathology_report'],
      acetic_acid_img_path: map['acetic_acid_img_path'],
      green_filter_img_path: map['green_filter_img_path'],
      lugol_iodine_img_path: map['lugol_iodine_img_path'],
      normal_saline_img_path: map['normal_saline_img_path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Patient(patient_name: $patient_name, patient_id: $patient_id, patient_age: $patient_age, doctor_name: $doctor_name, hospital_name: $hospital_name, margin_and_surface: $margin_and_surface, vessel: $vessel, lesion_size: $lesion_size, acetic_acid: $acetic_acid, lugol_iodine: $lugol_iodine, total_score: $total_score, biopsy_taken: $biopsy_taken, histopathology_report: $histopathology_report, acetic_acid_img_path: $acetic_acid_img_path, green_filter_img_path: $green_filter_img_path, lugol_iodine_img_path: $lugol_iodine_img_path, normal_saline_img_path: $normal_saline_img_path)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Patient &&
        other.patient_name == patient_name &&
        other.patient_id == patient_id &&
        other.patient_age == patient_age &&
        other.doctor_name == doctor_name &&
        other.hospital_name == hospital_name &&
        other.margin_and_surface == margin_and_surface &&
        other.vessel == vessel &&
        other.lesion_size == lesion_size &&
        other.acetic_acid == acetic_acid &&
        other.lugol_iodine == lugol_iodine &&
        other.total_score == total_score &&
        other.biopsy_taken == biopsy_taken &&
        other.histopathology_report == histopathology_report &&
        other.acetic_acid_img_path == acetic_acid_img_path &&
        other.green_filter_img_path == green_filter_img_path &&
        other.lugol_iodine_img_path == lugol_iodine_img_path &&
        other.normal_saline_img_path == normal_saline_img_path;
  }

  @override
  int get hashCode {
    return patient_name.hashCode ^
        patient_id.hashCode ^
        patient_age.hashCode ^
        doctor_name.hashCode ^
        hospital_name.hashCode ^
        margin_and_surface.hashCode ^
        vessel.hashCode ^
        lesion_size.hashCode ^
        acetic_acid.hashCode ^
        lugol_iodine.hashCode ^
        total_score.hashCode ^
        biopsy_taken.hashCode ^
        histopathology_report.hashCode ^
        acetic_acid_img_path.hashCode ^
        green_filter_img_path.hashCode ^
        lugol_iodine_img_path.hashCode ^
        normal_saline_img_path.hashCode;
  }
}
