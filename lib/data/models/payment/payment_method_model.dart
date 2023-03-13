// ignore_for_file: annotate_overrides, overridden_fields

import 'package:jd_mobile/domain/entities/payment/payment_method_entities.dart';

class PaymentMethodModel extends PaymentMethodEntities {
  final String? pgCode;
  final String? pgName;

  PaymentMethodModel({this.pgCode, this.pgName});
  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      pgCode: json["pg_code"],
      pgName: json["pg_name"],
    );
  }
}
