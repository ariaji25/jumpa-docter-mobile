import 'package:firebase_auth/firebase_auth.dart';

class ErrorAuthHelper {
  ErrorAuthHelper._();

  static String getAuthErrorMessage(FirebaseAuthException e) {
    if (e.code == "invalid-verification-code") {
      return "OTP tidak valid";
    } else if (e.code == "code-expired") {
      return "Kode kedaluwarsa. Coba lagi dengan kode baru";
    } else if (e.code == "internal-error") {
      return "Kesalahan yang tidak diketahui. Silakan coba lagi setelah beberapa saat";
    } else if (e.code == "invalid-phone-number") {
      return "Nomor telepon tidak valid";
    } else if (e.code == "invalid-verification-id") {
      return "Id verifikasi tidak valid";
    } else if (e.code == "quota-exceeded") {
      return "Kami menerima terlalu banyak permintaan. Silakan coba lagi setelah beberapa saat";
    } else if (e.code == "timeout") {
      return "Waktu habis. Harap verifikasi lagi";
    } else if (e.code == "too-many-requests") {
      return "Kami menerima terlalu banyak permintaan. Coba lagi setelah beberapa saat";
    }
    return e.message.toString();
  }
}