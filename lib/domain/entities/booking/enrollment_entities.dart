// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class EnrollmentEntities extends Equatable {
  String? program;
  String? orgUnit;
  String? trackedEntityInstance;
  String? trackedEntityType;
  String? status;

  EnrollmentEntities({
    this.program,
    this.orgUnit,
    this.trackedEntityInstance,
    this.trackedEntityType,
    this.status,
  });

  @override
  List<Object?> get props => [
        program,
        orgUnit,
        trackedEntityInstance,
        trackedEntityType,
        status,
      ];
}
