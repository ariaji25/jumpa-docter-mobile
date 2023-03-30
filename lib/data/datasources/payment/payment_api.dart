import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'payment_api.g.dart';

@RestApi()
abstract class PaymentApi {
  @POST("/api/payment")
  Future generatePayment(@Body() Map<String, dynamic> data);

  @GET("/api/payment-channels")
  Future getPaymentMethod();

  @GET("/api/payment-status/{bookingId}")
  Future checkPaymentStatus(@Path('bookingId') bookingId);

  factory PaymentApi(Dio dio, {String baseUrl}) = _PaymentApi;
}
