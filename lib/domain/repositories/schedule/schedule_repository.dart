import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/patient/event_entities.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, List<EventEntities>>> getHistoryEnrollments(
    String patientId,
  );

  Future<Either<Failure, List<EventEntities>>> getEnrollments(
    String patientId,
  );

  Future<Either<Failure, List<EventEntities>>> getDetailEnrollment(
  Map<String,dynamic> data);
}
