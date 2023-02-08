import 'package:firebase_auth/firebase_auth.dart';
import 'package:jd_mobile/data/datasources/firebase/auth/auth_firebase.dart';

class AuthFirebaseImpl implements AuthFirebase {
  final FirebaseAuth auth;
  AuthFirebaseImpl({required this.auth});

  @override
  Future<String?> signIn({required String verificationId, required String smsCode}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await auth.signInWithCredential(credential);
    final userCredential = auth.currentUser;
    return await userCredential?.getIdToken();
  }
}