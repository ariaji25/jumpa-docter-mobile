import 'package:jd_mobile/data/models/payment/payment_url_model.dart';

class PaymentUrlResponse {
  PaymentUrlModel data;

  PaymentUrlResponse({required this.data});
  factory PaymentUrlResponse.fromJson(Map<String, dynamic> json) {
    return PaymentUrlResponse(
      data: PaymentUrlModel.fromJson(
        json["data"],
      ),
    );
  }
}
