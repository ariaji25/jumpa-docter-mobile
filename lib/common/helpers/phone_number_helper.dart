class PhoneNumberHelper {
  PhoneNumberHelper._();

  static String formatPhoneNumber(String phone) {
    String phoneNumber = "+62";
    if (phone.startsWith("0")) {
      phoneNumber += phone.substring(1, phone.length);
    } else if (phone.startsWith("+62")) {
      phoneNumber += phone.trim().replaceAll("+62", "");
    } else if (phone.startsWith("62")) {
      phoneNumber += phone.trim().replaceAll("62", "");
    } else if (phone.startsWith("00")) {
      phoneNumber += phone.trim().replaceAll("00", "");
    } else {
      phoneNumber += phone.trim();
    }

    return phoneNumber;
  }

  static bool isValidPhoneNumber(String? string) {
    if (string == null || string.isEmpty) {
      return false;
    }

    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }
}
