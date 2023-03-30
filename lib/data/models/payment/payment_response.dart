import 'package:jd_mobile/data/models/payment/payment_model.dart';

class PaymentResponse {
  PaymentModel data;
  PaymentResponse({required this.data});
  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      data: PaymentModel.fromJson(
        json["data"],
      ),
    );
  }
}
