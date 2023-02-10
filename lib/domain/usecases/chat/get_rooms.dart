import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/repositories/chat/chat_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class GetRooms extends UseCase<Either<Failure, String>, Map<String, dynamic>> {
  final ChatRepository repository;

  GetRooms(this.repository);

  @override
  Future<Either<Failure, String>> call(params) => repository.getRooms(params);
}
