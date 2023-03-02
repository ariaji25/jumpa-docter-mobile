// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:jd_mobile/domain/entities/booking/organisation_units_entities.dart';
import 'package:jd_mobile/domain/entities/booking/pager_entities.dart';

import '../chat/page_entities.dart';

class ClinicEntities extends Equatable {
  PagerEntities? pager;
  List<OrganisationUnitsEntities>? organisationUnits;

  ClinicEntities({this.pager, this.organisationUnits});

  @override
  List<Object?> get props => [pager, organisationUnits];
}
