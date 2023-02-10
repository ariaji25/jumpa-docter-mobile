import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/patient/patient_entities.dart';
import 'package:jd_mobile/domain/repositories/patient/patient_repositorty.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class CreatePatient
    extends UseCase<Either<Failure, String>, PatientEntities> {
  final PatientRepository repository;

  CreatePatient(this.repository);

  @override
  Future<Either<Failure, String>> call(PatientEntities params) =>
      repository.createPatient(params);
}
