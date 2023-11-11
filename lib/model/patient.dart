// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Patient {
  final String patient_name;
  final String patient_id;
  final int patient_age;
  final String doctor_name;
  final String hospital_name;
  final int margin_and_surface;
  final int vessel;
  final int lesion_size;
  final int acetic_acid;
  final int lugol_iodine;
  final int total_score;
  final String biopsy_taken;
  final String histopathology_report;
  final String acetic_acid_img_path;
  final String green_filter_img_path;
  final String lugol_iodine_img_path;
  final String normal_saline_img_path;

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
    required this.lugol_iodine_img_path,
    required this.green_filter_img_path,
    required this.normal_saline_img_path,
    required this.acetic_acid_img_path,
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
    String? lugol_iodine_img_path,
    String? green_filter_img_path,
    String? normal_saline_img_path,
    String? acetic_acid_img_path,
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
      lugol_iodine_img_path:
          lugol_iodine_img_path ?? this.lugol_iodine_img_path,
      green_filter_img_path:
          green_filter_img_path ?? this.green_filter_img_path,
      normal_saline_img_path:
          normal_saline_img_path ?? this.normal_saline_img_path,
      acetic_acid_img_path: acetic_acid_img_path ?? this.acetic_acid_img_path,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'patient_name': patient_name});
    result.addAll({'patient_id': patient_id});
    result.addAll({'patient_age': patient_age});
    result.addAll({'doctor_name': doctor_name});
    result.addAll({'hospital_name': hospital_name});
    result.addAll({'margin_and_surface': margin_and_surface});
    result.addAll({'vessel': vessel});
    result.addAll({'lesion_size': lesion_size});
    result.addAll({'acetic_acid': acetic_acid});
    result.addAll({'lugol_iodine': lugol_iodine});
    result.addAll({'total_score': total_score});
    result.addAll({'biopsy_taken': biopsy_taken});
    result.addAll({'histopathology_report': histopathology_report});
    result.addAll({'lugol_iodine_img_path': lugol_iodine_img_path});
    result.addAll({'green_filter_img_path': green_filter_img_path});
    result.addAll({'normal_saline_img_path': normal_saline_img_path});
    result.addAll({'acetic_acid_img_path': acetic_acid_img_path});

    return result;
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      patient_name: map['patient_name'] ?? '',
      patient_id: map['patient_id'] ?? '',
      patient_age: map['patient_age']?.toInt() ?? 0,
      doctor_name: map['doctor_name'] ?? '',
      hospital_name: map['hospital_name'] ?? '',
      margin_and_surface: map['margin_and_surface']?.toInt() ?? 0,
      vessel: map['vessel']?.toInt() ?? 0,
      lesion_size: map['lesion_size']?.toInt() ?? 0,
      acetic_acid: map['acetic_acid']?.toInt() ?? 0,
      lugol_iodine: map['lugol_iodine']?.toInt() ?? 0,
      total_score: map['total_score']?.toInt() ?? 0,
      biopsy_taken: map['biopsy_taken'] ?? '',
      histopathology_report: map['histopathology_report'] ?? '',
      lugol_iodine_img_path: map['lugol_iodine_img_path'] ?? '',
      green_filter_img_path: map['green_filter_img_path'] ?? '',
      normal_saline_img_path: map['normal_saline_img_path'] ?? '',
      acetic_acid_img_path: map['acetic_acid_img_path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Patient(patient_name: $patient_name, patient_id: $patient_id, patient_age: $patient_age, doctor_name: $doctor_name, hospital_name: $hospital_name, margin_and_surface: $margin_and_surface, vessel: $vessel, lesion_size: $lesion_size, acetic_acid: $acetic_acid, lugol_iodine: $lugol_iodine, total_score: $total_score, biopsy_taken: $biopsy_taken, histopathology_report: $histopathology_report, lugol_iodine_img_path: $lugol_iodine_img_path, green_filter_img_path: $green_filter_img_path, normal_saline_img_path: $normal_saline_img_path, acetic_acid_img_path: $acetic_acid_img_path)';
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
        other.lugol_iodine_img_path == lugol_iodine_img_path &&
        other.green_filter_img_path == green_filter_img_path &&
        other.normal_saline_img_path == normal_saline_img_path &&
        other.acetic_acid_img_path == acetic_acid_img_path;
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
        lugol_iodine_img_path.hashCode ^
        green_filter_img_path.hashCode ^
        normal_saline_img_path.hashCode ^
        acetic_acid_img_path.hashCode;
  }
}
