// ignore_for_file: annotate_overrides, overridden_fields

import 'package:jd_mobile/domain/entities/patient/datavalue_entities.dart';
import 'package:jd_mobile/domain/entities/patient/element_entities.dart';
import 'package:jd_mobile/domain/entities/patient/event_entities.dart';

import 'datavalue_model.dart';

class EventModel extends EventEntities with ElementsEntities {
  List<DataValueEntities>? dataValues;
  String? bookingId;

  EventModel({this.dataValues});

  EventModel.fromJson(Map<String, dynamic> json) {
    if (json["dataValues"] != null) {
      dataValues = [];
      json["dataValues"].forEach((v) {
        dataValues?.add(DataValueModel.fromJson(v));
      });
    }

    bookingId = json["event"];
  }
}
