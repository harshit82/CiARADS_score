import 'dart:convert';

class Patient {
  final String patientName;
  final String patientId;
  final int patientAge;
  final String doctorName;
  final String hospitalId;

  Patient({
    required this.patientName,
    required this.patientId,
    required this.patientAge,
    required this.doctorName,
    required this.hospitalId,
  });

  Patient copyWith({
    String? patientName,
    String? patientId,
    int? patientAge,
    String? doctorName,
    String? hospitalId,
  }) {
    return Patient(
      patientName: patientName ?? this.patientName,
      patientId: patientId ?? this.patientId,
      patientAge: patientAge ?? this.patientAge,
      doctorName: doctorName ?? this.doctorName,
      hospitalId: hospitalId ?? this.hospitalId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'patientName': patientName});
    result.addAll({'patientId': patientId});
    result.addAll({'patientAge': patientAge});
    result.addAll({'doctorName': doctorName});
    result.addAll({'hospitalId': hospitalId});

    return result;
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      patientName: map['patientName'] ?? '',
      patientId: map['patientId'] ?? '',
      patientAge: map['patientAge']?.toInt() ?? 0,
      doctorName: map['doctorName'] ?? '',
      hospitalId: map['hospitalId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Patient(patientName: $patientName, patientId: $patientId, patientAge: $patientAge, doctorName: $doctorName, hospitalId: $hospitalId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Patient &&
        other.patientName == patientName &&
        other.patientId == patientId &&
        other.patientAge == patientAge &&
        other.doctorName == doctorName &&
        other.hospitalId == hospitalId;
  }

  @override
  int get hashCode {
    return patientName.hashCode ^
        patientId.hashCode ^
        patientAge.hashCode ^
        doctorName.hashCode ^
        hospitalId.hashCode;
  }
}
