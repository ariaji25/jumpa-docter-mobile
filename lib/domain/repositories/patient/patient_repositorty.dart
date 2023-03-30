import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/patient/patient_entities.dart';

abstract class PatientRepository {
  Future<Either<Failure, String>> createPatient(PatientEntities data);

  Future<Either<Failure, String>> createPatientNrm(Map<String, dynamic> data);

  Future<Either<Failure, String>> updatePatient(Map<String, dynamic> data);

  Future<Either<Failure, String>> detailPatientByNrm(String phoneNumber);

  Future<Either<Failure, String>> detailPatientByNik(String nik);
}
