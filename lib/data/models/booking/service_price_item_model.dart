// ignore_for_file: must_be_immutable

import 'package:jd_mobile/domain/entities/booking/service_price_item_entities.dart';

class ServicePriceItemModel extends ServicePriceItemEntities {
  ServicePriceItemModel({
    dataElement,
    period,
    orgUnit,
    categoryOptionCombo,
    attributeOptionCombo,
    value,
    storedBy,
    created,
    lastUpdated,
    followup,
  });

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
