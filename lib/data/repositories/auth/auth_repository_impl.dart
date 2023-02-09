import 'package:firebase_auth/firebase_auth.dart';
import 'package:jd_mobile/common/helpers/error_auth_helper.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:dartz/dartz.dart';
import 'package:jd_mobile/data/datasources/firebase/auth/auth_firebase.dart';
import 'package:jd_mobile/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthFirebase authFirebase;
  AuthRepositoryImpl({required this.authFirebase});

  @override
  Future<Either<Failure, String>> signIn(String verificationId, String smsCode) async {
    try {
      final result = await authFirebase.signIn(verificationId: verificationId, smsCode: smsCode);
      if(result != null) return Right(result);
      return const Left(ServerFailure("Token Not Found!"));
    } on FirebaseAuthException catch(e) {
      return Left(ServerFailure(ErrorAuthHelper.getAuthErrorMessage(e)));
    }
  }
}