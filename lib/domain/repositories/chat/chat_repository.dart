import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';

abstract class ChatRepository {
  Future<Either<Failure, String>> getRooms(Map<String, dynamic> params);
}
