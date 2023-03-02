import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/booking/clinic_entities.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

import '../../repositories/order/order_repository.dart';

class GetClinics extends UseCase<Either<Failure, ClinicEntities>, String> {
  final OrderRepository repository;

  GetClinics(this.repository);

  @override
  Future<Either<Failure, ClinicEntities>> call(params) =>
      repository.getClinics();
}
