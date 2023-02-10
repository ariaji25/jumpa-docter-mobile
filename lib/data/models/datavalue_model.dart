// ignore_for_file: annotate_overrides, overridden_fields

import 'package:jd_mobile/domain/entities/patient/datavalue_entities.dart';

class DataValueModel extends DataValueEntities {
  DataValueModel({
    this.lastUpdated,
    this.created,
    this.dataElement,
    this.value,
    this.providedElsewhere,
  });

  DateTime? lastUpdated;
  DateTime? created;
  String? dataElement;
  String? value;
  bool? providedElsewhere;

  factory DataValueModel.fromJson(Map<String, dynamic> json) {
    return DataValueModel(
      lastUpdated: DateTime.parse(json["lastUpdated"]),
      created: DateTime.parse(json["created"]),
      dataElement: json["dataElement"],
      value: json["value"],
      providedElsewhere: json["providedElsewhere"],
    );
  }
}
