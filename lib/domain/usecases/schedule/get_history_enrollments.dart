import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/repositories/schedule/schedule_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

import '../../entities/patient/event_entities.dart';

class GetHistoryEnrollments
    extends UseCase<Either<Failure, List<EventEntities>>, String> {
  final ScheduleRepository repository;

  GetHistoryEnrollments(this.repository);

  @override
  Future<Either<Failure, List<EventEntities>>> call(params) =>
      repository.getHistoryEnrollments(params);
}
