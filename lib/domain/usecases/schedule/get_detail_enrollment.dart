import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/patient/event_entities.dart';
import 'package:jd_mobile/domain/repositories/schedule/schedule_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class GetDetailEnrollment
    extends UseCase<Either<Failure, List<EventEntities>>, Map<String,dynamic>> {
  final ScheduleRepository repository;

  GetDetailEnrollment(this.repository);

  @override
  Future<Either<Failure, List<EventEntities>>> call(Map<String,dynamic> params) =>
      repository.getDetailEnrollment(params);
}
