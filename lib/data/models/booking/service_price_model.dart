// ignore_for_file: overridden_fields, annotate_overrides, must_be_immutable

import 'package:jd_mobile/data/models/booking/service_price_item_model.dart';
import 'package:jd_mobile/domain/entities/booking/service_price_entities.dart';

import '../../../domain/entities/booking/service_price_item_entities.dart';

class ServicePriceModel extends ServicePriceEntities {
  ServicePriceModel({
    this.dataValues,
  });

  List<ServicePriceItemEntities>? dataValues;

  factory ServicePriceModel.fromJson(Map<String, dynamic> json) {
    if (json["dataValues"] != null) {
      List<ServicePriceItemEntities> data = [];
      for ( var item in json["dataValues"] ){
        data.add(ServicePriceItemModel.fromJson(item));
      }
      return ServicePriceModel(dataValues: data);
    }
    return ServicePriceModel();
  }
}
