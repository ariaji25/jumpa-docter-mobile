// ignore_for_file: must_be_immutable

import 'package:jd_mobile/domain/entities/booking/service_price_entities.dart';

class ServicePriceModel extends ServicePriceEntities {
  ServicePriceModel({
    dataValues,
  });

  factory ServicePriceModel.fromJson(Map<String, dynamic> json) =>
      ServicePriceModel(
        dataValues: List<ServicePriceEntities>.from(
            json["dataValues"].map((x) => ServicePriceModel.fromJson(x))),
      );
}
