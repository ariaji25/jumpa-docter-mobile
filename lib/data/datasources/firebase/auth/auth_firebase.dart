abstract class AuthFirebase {
  Future<String?> signIn({required String verificationId, required String smsCode});
}