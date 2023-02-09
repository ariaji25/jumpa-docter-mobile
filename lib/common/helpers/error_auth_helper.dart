import 'package:firebase_auth/firebase_auth.dart';

class ErrorAuthHelper {
  ErrorAuthHelper._();

  static String getAuthErrorMessage(FirebaseAuthException e) {
    if (e.code == "invalid-verification-code") {
      return "Invalid OTP";
    } else if (e.code == "code-expired") {
      return "Code expired. Try again with new code";
    } else if (e.code == "internal-error") {
      return "Unknown error. Please try again after sometime";
    } else if (e.code == "invalid-phone-number") {
      return "Invalid phone number";
    } else if (e.code == "invalid-verification-id") {
      return "Invalid verification id";
    } else if (e.code == "quota-exceeded") {
      return "We are receiving too many requests. Please try again after sometime";
    } else if (e.code == "timeout") {
      return "Timeout. Please verify again";
    } else if (e.code == "too-many-requests") {
      return "We are receiving too many requests. Try again after sometime";
    }
    return e.message.toString();
  }
}