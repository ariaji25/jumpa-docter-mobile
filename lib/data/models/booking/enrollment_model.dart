// ignore_for_file: overridden_fields, annotate_overrides, must_be_immutable

import '../../../domain/entities/booking/enrollment_entities.dart';

class EnrollmentModel extends EnrollmentEntities {
  String? program;
  String? orgUnit;
  String? trackedEntityInstance;
  String? trackedEntityType;
  String? status;
  String? storedBy;
  String? created;
  String? createdAtClient;
  String? enrollment;
  String? lastUpdated;
  String? lastUpdatedAtClient;
  String? orgUnitName;
  String? enrollmentDate;
  String? completedDate;
  bool? deleted;
  String? incidentDate;
  String? completedBy;

  EnrollmentModel({
    this.program,
    this.orgUnit,
    this.trackedEntityInstance,
    this.trackedEntityType,
    this.status,
    this.storedBy,
    this.created,
    this.createdAtClient,
    this.enrollment,
    this.lastUpdated,
    this.lastUpdatedAtClient,
    this.orgUnitName,
    this.enrollmentDate,
    this.completedDate,
    this.deleted,
    this.incidentDate,
    this.completedBy,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) =>
      EnrollmentModel(
        program: json["program"],
        orgUnit: json["orgUnit"],
        trackedEntityInstance: json["trackedEntityInstance"],
        trackedEntityType: json["trackedEntityType"],
        status: json["status"],
        storedBy: json["storedBy"],
        created: json["created"],
        createdAtClient: json["createdAtClient"],
        enrollment: json["enrollment"],
        lastUpdated: json["lastUpdated"],
        lastUpdatedAtClient: json["lastUpdatedAtClient"],
        orgUnitName: json["orgUnitName"],
        enrollmentDate: json["enrollmentDate"],
        completedDate: json["completedDate"],
        deleted: json["deleted"],
        incidentDate: json["incidentDate"],
        completedBy: json["completedBy"],
      );

  factory EnrollmentModel.fromEntities(EnrollmentEntities enrollmentEntities) =>
      EnrollmentModel(
        program: enrollmentEntities.program,
        orgUnit: enrollmentEntities.orgUnit,
        trackedEntityInstance: enrollmentEntities.trackedEntityInstance,
        trackedEntityType: enrollmentEntities.trackedEntityType,
        status: enrollmentEntities.status,
        storedBy: enrollmentEntities.storedBy,
        created: enrollmentEntities.created,
        createdAtClient: enrollmentEntities.createdAtClient,
        enrollment: enrollmentEntities.enrollment,
        lastUpdated: enrollmentEntities.lastUpdated,
        lastUpdatedAtClient: enrollmentEntities.lastUpdatedAtClient,
        orgUnitName: enrollmentEntities.orgUnitName,
        enrollmentDate: enrollmentEntities.enrollmentDate,
        completedDate: enrollmentEntities.completedDate,
        deleted: enrollmentEntities.deleted,
        incidentDate: enrollmentEntities.incidentDate,
        completedBy: enrollmentEntities.completedBy,
      );

  Map<String, dynamic> toJson() => {
        "program": program,
        "orgUnit": orgUnit,
        "trackedEntityInstance": trackedEntityInstance,
        "trackedEntityType": trackedEntityType,
        "status": status,
        "storedBy": storedBy,
        "created": created,
        "createdAtClient": createdAtClient,
        "enrollment": enrollment,
        "lastUpdated": lastUpdated,
        "lastUpdatedAtClient": lastUpdatedAtClient,
        "orgUnitName": orgUnitName,
        "enrollmentDate": enrollmentDate,
        "completedDate": completedDate,
        "deleted": deleted,
        "incidentDate": incidentDate,
        "completedBy": completedBy,
      };
}
