import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/repositories/order/order_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

import '../../entities/booking/doctor_entities.dart';
import '../../entities/patient/detail_patient_entities.dart';

class GetDoctors extends UseCase<Either<Failure, DetailPatientEntities>, String> {
  final OrderRepository repository;

  GetDoctors(this.repository);

  @override
  Future<Either<Failure, DetailPatientEntities>> call(params) =>
      repository.getDoctors(params);
}
