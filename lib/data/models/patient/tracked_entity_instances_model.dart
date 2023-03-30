// ignore_for_file: annotate_overrides, overridden_fields

import 'package:jd_mobile/data/models/booking/enrollment_model.dart';
import 'package:jd_mobile/domain/entities/patient/attribute_entities.dart';
import 'package:jd_mobile/domain/entities/patient/tracked_entity_instances_entities.dart';
import '../../../domain/entities/booking/enrollment_entities.dart';
import 'attributes_model.dart';

class TrackedEntityInstancesModel extends TrackedEntityInstancesEntities {
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

  TrackedEntityInstancesModel(
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

  TrackedEntityInstancesModel.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    orgUnit = json['orgUnit'];
    createdAtClient = json['createdAtClient'];
    trackedEntityInstance = json['trackedEntityInstance'];
    lastUpdated = json['lastUpdated'];
    trackedEntityType = json['trackedEntityType'];
    lastUpdatedAtClient = json['lastUpdatedAtClient'];
    inactive = json['inactive'];
    deleted = json['deleted'];
    featureType = json['featureType'];
    if (json['programOwners'] != null) {
      programOwners = [];
      json['programOwners'].forEach((v) {
        programOwners?.add(v);
      });
    }
    if (json['enrollments'] != null) {
      enrollments = [];
      json['enrollments'].forEach((v) {
        enrollments?.add(EnrollmentModel.fromJson(v));
      });
    }
    if (json['relationships'] != null) {
      relationships = [];
      json['relationships'].forEach((v) {
        relationships?.add([]);
      });
    }
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add(AttributesModel.fromJson(v));
      });
    }
  }
}
