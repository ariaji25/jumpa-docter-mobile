// ignore_for_file: annotate_overrides, overridden_fields

import 'package:jd_mobile/domain/entities/detail_patient_entities.dart';
import 'package:jd_mobile/domain/entities/tracked_entity_instances_entities.dart';

import 'tracked_entity_instances_model.dart';

class DetailPatientModel extends DetailPatientEntities{
  List<TrackedEntityInstancesEntities>? trackedEntityInstances;

  DetailPatientModel({this.trackedEntityInstances});

  DetailPatientModel.fromJson(Map<String, dynamic> json) {
    if (json['trackedEntityInstances'] != null) {
      trackedEntityInstances = [];
      json['trackedEntityInstances'].forEach((v) {
        trackedEntityInstances?.add(TrackedEntityInstancesModel.fromJson(v));
      });
    }
  }
}