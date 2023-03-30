import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/payment/payment_entities.dart';
import 'package:jd_mobile/domain/entities/payment/payment_url_enities.dart';

abstract class PaymentRespository {
  Future<Either<Failure, PaymentEntites>> getPaymentMethod();
  Future<Either<Failure, String>> checkPaymentStatus(String bookingId);
  Future<Either<Failure, PaymentUrlEntities>> genratePayment(Map<String, dynamic> data);
}
