import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/repositories/payment/payment_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class GetPaymentStatus extends UseCase<Either<Failure, String>, String> {
  final PaymentRespository repository;
  GetPaymentStatus(this.repository);
  
  @override
  Future<Either<Failure, String>> call(String params) => repository.checkPaymentStatus(params);
}
