import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/data/datasources/http_services.dart';
import 'package:jd_mobile/domain/usecases/auth/sign_in.dart';
import 'package:jd_mobile/injection.dart' as di;

class AuthProvider extends ChangeNotifier {
  final SignIn signIn;

  AuthProvider({required this.signIn});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  RequestState _requestState = RequestState.Empty;

  RequestState get requestState => _requestState;

  void setRequestState(RequestState state) {
    _requestState = state;
    notifyListeners();
  }

  String _errMsg = AppConst.EMPTY_STRING;

  String get errMsg => _errMsg;

  String verificationId = AppConst.EMPTY_STRING;
  String smsCode = AppConst.EMPTY_STRING;
  int? resendToken = 0;

  final _auth = di.getIt<FirebaseAuth>();

  void clearCode() {
    verificationId = AppConst.EMPTY_STRING;
    smsCode = AppConst.EMPTY_STRING;
    resendToken = 0;
  }

  Future<void> signInUser() async {
    _state = RequestState.Loading;
    notifyListeners();
    final ress = await signIn.call(Tuple2(verificationId, smsCode));
    ress.fold(
      (l) {
        _state = RequestState.Error;
        _errMsg = l.message;
        notifyListeners();
      },
      (r) {
        _state = RequestState.Loaded;
        di.getIt<HttpService>().setToken(token: r);
        const FlutterSecureStorage().write(key: AppConst.AUTH_TOKEN, value: r);
        log("TOKEN -- $r");
        notifyListeners();
      },
    );
  }

  Future<void> requestOtp({
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
    Duration timeout = const Duration(seconds: 30),
    String? phoneNumber,
  }) async {
    _requestState = RequestState.Loading;
    notifyListeners();
    await _auth.verifyPhoneNumber(
      timeout: timeout,
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future logout() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: AppConst.AUTH_TOKEN);
    log("TOKEN IN LOGOUT $token");
    await storage.deleteAll();
    log("TOKEN LOGOUT :: ${await storage.read(key: AppConst.AUTH_TOKEN)}");
  }
}
