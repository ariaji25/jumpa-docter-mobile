// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class EnrollmentEntities extends Equatable {
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

  EnrollmentEntities({
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

  @override
  List<Object?> get props => [
        program,
        orgUnit,
        trackedEntityInstance,
        trackedEntityType,
        status,
        storedBy,
        created,
        createdAtClient,
        enrollment,
        lastUpdated,
        lastUpdatedAtClient,
        orgUnitName,
        enrollmentDate,
        completedDate,
        deleted,
        incidentDate,
        completedBy,
      ];
}
