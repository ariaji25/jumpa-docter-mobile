// ignore_for_file: annotate_overrides, overridden_fields

import 'package:jd_mobile/data/models/payment/payment_method_model.dart';
import 'package:jd_mobile/domain/entities/payment/payment_entities.dart';

class PaymentModel extends PaymentEntites{
  final List<PaymentMethodModel>? va;
  final List<PaymentMethodModel>? eWallet;

  PaymentModel({
    this.va,
    this.eWallet,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      va: List<PaymentMethodModel>.from(
        json["va"].map(
          (x) => PaymentMethodModel.fromJson(x),
        ),
      ),
      eWallet: List<PaymentMethodModel>.from(
        json["eWallet"].map(
          (x) => PaymentMethodModel.fromJson(x),
        ),
      ),
    );
  }
}
