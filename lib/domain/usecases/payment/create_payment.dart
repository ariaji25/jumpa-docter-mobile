import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/payment/payment_url_enities.dart';
import 'package:jd_mobile/domain/repositories/payment/payment_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class CreatePayment extends UseCase<Either<Failure, PaymentUrlEntities>, Map<String, dynamic>> {
  final PaymentRespository repository;
  CreatePayment(this.repository);
  
  @override
  Future<Either<Failure, PaymentUrlEntities>> call(Map<String, dynamic> params) => repository.genratePayment(params);
}
