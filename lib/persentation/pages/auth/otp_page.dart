import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jd_mobile/common/extensions/padding_ext.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/widgets/app_bars.dart';

class OtpPage extends StatefulWidget {
  static const routeName = "/OtpPage";
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppsBar(
        elevation: 0,
        isWhite: true,
        title: Padding(
          padding: paddingOnly(
            left: 16.0,
            right: 25.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: paddingTop(SizeConstants.margin),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: paddingOnly(top: 20.0),
                child: SizedBox(
                  height: 25,
                  width: 74,
                  child: Image.asset(Assets.logoSplash),
                ),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.white,
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: paddingOnly(
          left: 25.0,
          right: 25.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kode OTP",
              style: AppTheme.bodyText.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                text:
                    "Kami sudah mengirimkan kode OTP melalui\nWhatsapp ke nomor ",
                style: GoogleFonts.inter(
                  color: AppColors.primaryColorDarkColor,
                  fontSize: 12,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "8123456789",
                    style: AppTheme.bodyText.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                      fontSize: 12,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "Kode OTP",
                textAlign: TextAlign.center,
                style: AppTheme.bodyText.copyWith(
                  color: const Color(0XFF16192C),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 15),
            OtpTextField(
              onSubmit: (value) {
                _otpCtrl.text = value;
              },
              focusedBorderColor: AppColors.primaryColor,
              fieldWidth: MediaQuery.of(context).size.width / 8,
              numberOfFields: 6,
              borderColor: AppColors.primaryColor,
              showFieldAsBox: true,
            ),
            const SizedBox(height: 30),
            const SizedBox(height: 30),
            InkWell(
              onTap: _onNext,
              child: Container(
                height: 47,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    "Lanjut",
                    style: AppTheme.bodyText.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onNext() {
    log("OTP CODE -- ${_otpCtrl.text}");
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
