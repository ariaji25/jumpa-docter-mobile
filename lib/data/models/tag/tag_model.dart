// ignore_for_file: overridden_fields, annotate_overrides

import 'package:jd_mobile/domain/entities/tag/tag_entities.dart';

class TagModel extends TagEntities {
  TagModel({this.data});

  List<String>? data;

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(data: List<String>.from(json["data"].map((x) => x)));
  }
}
