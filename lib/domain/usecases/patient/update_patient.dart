import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/repositories/patient/patient_repositorty.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class UpdatePatient
    extends UseCase<Either<Failure, String>, Map<String,dynamic>> {
  final PatientRepository repository;

  UpdatePatient(this.repository);

  @override
  Future<Either<Failure, String>> call(Map<String,dynamic> params) =>
      repository.updatePatient(params);
}
