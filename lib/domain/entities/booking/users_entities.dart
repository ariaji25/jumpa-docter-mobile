// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class UsersEntities extends Equatable {
  String? id;
  String? name;

  UsersEntities({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
