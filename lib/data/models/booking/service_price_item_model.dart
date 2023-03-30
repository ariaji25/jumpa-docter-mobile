// ignore_for_file: overridden_fields, annotate_overrides, must_be_immutable

import 'package:jd_mobile/domain/entities/booking/service_price_item_entities.dart';

class ServicePriceItemModel extends ServicePriceItemEntities {
  ServicePriceItemModel({
    this.dataElement,
    this.period,
    this.orgUnit,
    this.categoryOptionCombo,
    this.attributeOptionCombo,
    this.value,
    this.storedBy,
    this.created,
    this.lastUpdated,
    this.followup,
  });

  String? dataElement;
  String? period;
  String? orgUnit;
  String? categoryOptionCombo;
  String? attributeOptionCombo;
  String? value;
  String? storedBy;
  String? created;
  String? lastUpdated;
  bool? followup;

  factory ServicePriceItemModel.fromJson(Map<String, dynamic> json) =>
      ServicePriceItemModel(
        dataElement: json["dataElement"],
        period: json["period"],
        orgUnit: json["orgUnit"],
        categoryOptionCombo: json["categoryOptionCombo"],
        attributeOptionCombo: json["attributeOptionCombo"],
        value: json["value"],
        storedBy: json["storedBy"],
        created: json["created"],
        lastUpdated: json["lastUpdated"],
        followup: json["followup"],
      );

  Map<String, dynamic> toJson() => {
        "dataElement": dataElement,
        "period": period,
        "orgUnit": orgUnit,
        "categoryOptionCombo": categoryOptionCombo,
        "attributeOptionCombo": attributeOptionCombo,
        "value": value,
        "storedBy": storedBy,
        "created": created,
        "lastUpdated": lastUpdated,
        "followup": followup,
      };
}
