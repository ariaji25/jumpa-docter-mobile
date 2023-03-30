// ignore_for_file: overridden_fields, annotate_overrides, must_be_immutable

import 'package:jd_mobile/domain/entities/booking/organisation_units_entities.dart';

class OrganisationUnitsModel extends OrganisationUnitsEntities {
  String? id;
  String? path;
  String? displayName;
  String? description;
  String? address;

  OrganisationUnitsModel({
    this.id,
    this.path,
    this.displayName,
    this.description,
    this.address,
  });

  OrganisationUnitsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    displayName = json['displayName'];
    description = json['description'];
    address = json['address'];
  }
}
