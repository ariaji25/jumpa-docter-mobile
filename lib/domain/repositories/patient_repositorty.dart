import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/patient_entities.dart';

abstract class PatientRepository {
  Future<Either<Failure, PatientEntities>> createPatient(PatientEntities model);
}
