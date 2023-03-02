// ignore_for_file: must_be_immutable

import 'package:jd_mobile/domain/entities/booking/doctor_entities.dart';

import 'pager_model.dart';
import 'users_model.dart';

class DoctorModel extends DoctorEntities {
  DoctorModel({pager, users});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    pager = json['pager'] != null ? PagerModel.fromJson(json['pager']) : null;
    if (json['users'] != null) {
      users = [];
      json['users'].forEach((v) {
        users?.add(UsersModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (pager != null) {
      data['pager'] = PagerModel(
              page: pager!.page,
              pageCount: pager!.pageCount,
              pageSize: pager!.pageSize,
              total: pager!.total)
          .toJson();
    }
    if (users != null) {
      data['users'] = users
          ?.map((v) => UsersModel(id: v.id, name: v.name).toJson())
          .toList();
    }
    return data;
  }
}
