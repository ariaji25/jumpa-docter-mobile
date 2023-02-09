import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/repositories/auth/auth_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class SignIn extends UseCase<Either<Failure, String>, Tuple2<String, String>> {
  final AuthRepository repository;
  SignIn(this.repository);
  
  @override
  Future<Either<Failure, String>> call(Tuple2<String, String> params) => repository.signIn(params.value1, params.value2);
}