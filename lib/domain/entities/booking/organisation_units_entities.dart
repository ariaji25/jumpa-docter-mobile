// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class OrganisationUnitsEntities extends Equatable {
  String? id;
  String? path;
  String? displayName;
  String? description;
  String? address;

  OrganisationUnitsEntities({
    this.id,
    this.path,
    this.displayName,
    this.description,
    this.address,
  });

  @override
  List<Object?> get props => [
        id,
        path,
        displayName,
        description,
        address,
      ];
}
