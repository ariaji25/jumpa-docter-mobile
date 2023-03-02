// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ServicePriceItemEntities extends Equatable {
  ServicePriceItemEntities({
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

  @override
  List<Object?> get props => [
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
      ];
}
