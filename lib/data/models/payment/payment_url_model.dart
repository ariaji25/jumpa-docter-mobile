// ignore_for_file: annotate_overrides, overridden_fields

import 'package:jd_mobile/domain/entities/payment/payment_url_enities.dart';

class PaymentUrlModel extends PaymentUrlEntities {
  String? paymentUrl;
  String? trxId;

  PaymentUrlModel({this.paymentUrl, this.trxId});
  factory PaymentUrlModel.fromJson(Map<String, dynamic> json) {
    return PaymentUrlModel(
      paymentUrl: json["payment_url"],
      trxId: json["trx_id"],
    );
  }
}
