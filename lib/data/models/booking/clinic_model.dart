// ignore_for_file: overridden_fields, annotate_overrides, must_be_immutable

import 'package:jd_mobile/domain/entities/booking/clinic_entities.dart';

import '../../../domain/entities/booking/organisation_units_entities.dart';
import '../../../domain/entities/booking/pager_entities.dart';
import 'organisation_units_model.dart';
import 'pager_model.dart';

class ClinicModel extends ClinicEntities {
  PagerEntities? pager;
  List<OrganisationUnitsEntities>? organisationUnits;
  ClinicModel({this.pager, this.organisationUnits});

  ClinicModel.fromJson(Map<String, dynamic> json) {
    pager = json['pager'] != null ? PagerModel.fromJson(json['pager']) : null;
    if (json['organisationUnits'] != null) {
      organisationUnits = [];
      json['organisationUnits'].forEach((v) {
        if (v['displayName'] != "Daerah Temporer") {
          organisationUnits?.add(OrganisationUnitsModel.fromJson(v));
        }
      });
    }
  }
}
