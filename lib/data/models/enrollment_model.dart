// ignore_for_file: annotate_overrides, overridden_fields

import 'package:jd_mobile/domain/entities/patient/enrollment_entities.dart';
import 'package:jd_mobile/domain/entities/patient/event_entities.dart';

import 'event_model.dart';

class EnrollmentModel extends EnrollmentEntities {
  List<EventEntities>? events;

  EnrollmentModel({this.events});

  EnrollmentModel.fromJson(Map<String, dynamic> json) {
    if (json["events"] != null) {
      events = [];
      json["events"].forEach((v) {
        if ((v["dataValues"] as List).isNotEmpty) {
          events?.add(EventModel.fromJson(v));
        }
      });
    }
  }
}
