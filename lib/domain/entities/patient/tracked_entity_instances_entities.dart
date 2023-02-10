import 'package:jd_mobile/domain/entities/patient/attribute_entities.dart';
import 'package:jd_mobile/domain/entities/patient/enrollment_entities.dart';

class TrackedEntityInstancesEntities {
  String? created;
  String? orgUnit;
  String? createdAtClient;
  String? trackedEntityInstance;
  String? lastUpdated;
  String? trackedEntityType;
  String? lastUpdatedAtClient;
  bool? inactive;
  bool? deleted;
  String? featureType;
  List<dynamic>? programOwners;
  List<EnrollmentEntities>? enrollments;
  List<dynamic>? relationships;
  List<AttributesEntities>? attributes;

  TrackedEntityInstancesEntities(
      {this.created,
        this.orgUnit,
        this.createdAtClient,
        this.trackedEntityInstance,
        this.lastUpdated,
        this.trackedEntityType,
        this.lastUpdatedAtClient,
        this.inactive,
        this.deleted,
        this.featureType,
        this.programOwners,
        this.enrollments,
        this.relationships,
        this.attributes});
}