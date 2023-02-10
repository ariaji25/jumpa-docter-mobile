import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/repositories/patient/patient_repositorty.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class CreatePatientNrm
    extends UseCase<Either<Failure, String>, Map<String,dynamic>> {
  final PatientRepository repository;

  CreatePatientNrm(this.repository);

  @override
  Future<Either<Failure, String>> call(Map<String,dynamic> params) =>
      repository.createPatientNrm(params);
}
