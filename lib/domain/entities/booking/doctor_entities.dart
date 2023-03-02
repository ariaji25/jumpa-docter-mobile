// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:jd_mobile/domain/entities/booking/pager_entities.dart';
import 'package:jd_mobile/domain/entities/booking/users_entities.dart';

class DoctorEntities extends Equatable {
  PagerEntities? pager;
  List<UsersEntities>? users;

  DoctorEntities({this.pager, this.users});

  @override
  List<Object?> get props => [pager, users];
}
