// ignore_for_file: overridden_fields, annotate_overrides, must_be_immutable

import '../../../domain/entities/booking/enrollment_entities.dart';

class EnrollmentModel extends EnrollmentEntities {
  String? program;
  String? orgUnit;
  String? trackedEntityInstance;
  String? trackedEntityType;
  String? status;

  EnrollmentModel({
    this.program,
    this.orgUnit,
    this.trackedEntityInstance,
    this.trackedEntityType,
    this.status,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) =>
      EnrollmentModel(
        program: json["program"],
        orgUnit: json["orgUnit"],
        trackedEntityInstance: json["trackedEntityInstance"],
        trackedEntityType: json["trackedEntityType"],
        status: json["status"],
      );

  factory EnrollmentModel.fromEntities(EnrollmentEntities enrollmentEntities) =>
      EnrollmentModel(
        program: enrollmentEntities.program,
        orgUnit: enrollmentEntities.orgUnit,
        trackedEntityInstance: enrollmentEntities.trackedEntityInstance,
        trackedEntityType: enrollmentEntities.trackedEntityType,
        status: enrollmentEntities.status,
      );

  Map<String, dynamic> toJson() => {
        "program": program,
        "orgUnit": orgUnit,
        "trackedEntityInstance": trackedEntityInstance,
        "trackedEntityType": trackedEntityType,
        "status": status,
      };
}
