// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:jd_mobile/domain/entities/booking/service_price_item_entities.dart';

class ServicePriceEntities extends Equatable {
  ServicePriceEntities({
    this.dataValues,
  });

  List<ServicePriceItemEntities>? dataValues;

  @override
  List<Object?> get props => [dataValues];
}
