import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/repositories/patient/patient_repositorty.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class DetailPatientByNik extends UseCase<Either<Failure, String>, String> {
  final PatientRepository repository;

  DetailPatientByNik(this.repository);

  @override
  Future<Either<Failure, String>> call(params) =>
      repository.detailPatientByNik(params);
}
