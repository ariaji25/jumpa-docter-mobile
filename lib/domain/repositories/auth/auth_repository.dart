import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signIn(String verificationId, String smsCode);
}