// ignore_for_file: annotate_overrides, overridden_fields

import 'package:jd_mobile/domain/entities/attribute_entities.dart';

class AttributesModel extends AttributesEntities {
  String? lastUpdated;
  String? storedBy;
  String? code;
  String? displayName;
  String? created;
  String? valueType;
  String? attribute;
  String? value;

  AttributesModel(
      {this.lastUpdated,
        this.storedBy,
        this.code,
        this.displayName,
        this.created,
        this.valueType,
        this.attribute,
        this.value});

  AttributesModel.fromJson(Map<String, dynamic> json) {
    lastUpdated = json['lastUpdated'];
    storedBy = json['storedBy'];
    code = json['code'];
    displayName = json['displayName'];
    created = json['created'];
    valueType = json['valueType'];
    attribute = json['attribute'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastUpdated'] = lastUpdated;
    data['storedBy'] = storedBy;
    data['code'] = code;
    data['displayName'] = displayName;
    data['created'] = created;
    data['valueType'] = valueType;
    data['attribute'] = attribute;
    data['value'] = value;
    return data;
  }
}