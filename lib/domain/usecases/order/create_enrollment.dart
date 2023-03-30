import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/repositories/order/order_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

import '../../entities/booking/enrollment_entities.dart';

class CreateEnrollment extends UseCase<Either<Failure, String>, EnrollmentEntities> {
  CreateEnrollment(this.repository);
  final OrderRepository repository;
 
  @override
  Future<Either<Failure, String>> call(EnrollmentEntities params) => repository.createEnrollment(params);
}