// ignore_for_file: overridden_fields, annotate_overrides, must_be_immutable

import 'package:jd_mobile/domain/entities/booking/users_entities.dart';

class UsersModel extends UsersEntities {
  String? id;
  String? name;

  UsersModel({
    this.id,
    this.name,
  });

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
