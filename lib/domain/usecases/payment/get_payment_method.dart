import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/payment/payment_entities.dart';
import 'package:jd_mobile/domain/repositories/payment/payment_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class GetPaymentMethod extends NoParamUseCase<Either<Failure, PaymentEntites>> {
  final PaymentRespository repository;
  GetPaymentMethod(this.repository);
  
  @override
  Future<Either<Failure, PaymentEntites>> call() => repository.getPaymentMethod();
}
