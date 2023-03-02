// ignore_for_file: must_be_immutable

import 'package:jd_mobile/domain/entities/booking/organisation_units_entities.dart';

class OrganisationUnitsModel extends OrganisationUnitsEntities {
  OrganisationUnitsModel({
    id,
    path,
    displayName,
    description,
    address,
  });

  OrganisationUnitsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    displayName = json['displayName'];
    description = json['description'];
    address = json['address'];
  }
}
