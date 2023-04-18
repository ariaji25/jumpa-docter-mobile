import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/extensions/padding_ext.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/common/resources/snackbar.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/persentation/pages/base/base_page.dart';
import 'package:jd_mobile/persentation/provider/auth/auth_provider.dart';
import 'package:jd_mobile/persentation/widgets/app_bars.dart';
import 'package:provider/provider.dart';

import '../../widgets/buttons.dart';

class OtpPage extends StatefulWidget {
  static const routeName = "/OtpPage";

  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late CountdownTimerController? controller;

  int endTime = DateTime.now().millisecondsSinceEpoch +
      const Duration(minutes: 3).inMilliseconds;

  void resetCountDown() {
    endTime = (DateTime.now().millisecondsSinceEpoch +
        const Duration(minutes: 3).inMilliseconds);
    controller = CountdownTimerController(endTime: endTime);
  }

  @override
  void initState() {
    resetCountDown();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    final params = ModalRoute.of(context)?.settings.arguments as List<String>;

    return Scaffold(
      backgroundColor: Colors.white,
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
                text: "Kami sudah mengirimkan kode OTP melalui\nSMS ke nomor ",
                style: GoogleFonts.inter(
                  color: AppColors.primaryColorDarkColor,
                  fontSize: 12,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: params[1],
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
                provider.otpCtrl.text = value;
                provider.setEnableButtonOtp(value.length == 6);
              },
              focusedBorderColor: provider.state == RequestState.Error
                  ? AppColors.dangerDarkColor
                  : AppColors.primaryColor,
              fieldWidth: MediaQuery.of(context).size.width / 8,
              keyboardType: TextInputType.number,
              numberOfFields: 6,
              borderRadius: BorderRadius.circular(5),
              borderColor: provider.state == RequestState.Error
                  ? AppColors.dangerDarkColor
                  : AppColors.primaryColor,
              enabledBorderColor: provider.state == RequestState.Error
                  ? AppColors.dangerDarkColor
                  : const Color(0xFFE7E7E7),
              cursorColor: provider.state == RequestState.Error
                  ? AppColors.dangerDarkColor
                  : AppColors.primaryColor,
              showFieldAsBox: true,
              autoFocus: true,
              textStyle: AppTheme.bodyText.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: provider.state == RequestState.Error
                    ? AppColors.dangerDarkColor
                    : AppColors.primaryColor,
              ),
              onCodeChanged: (value) {
                provider.handleOtp(value);
                provider.setEnableButtonOtp(provider.otpCtrl.text.length == 6);
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                      visible: provider.state == RequestState.Error,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          "Kode OTP salah atau kode sudah kadaluarsa, coba lagi beberapa saat",
                          textAlign: TextAlign.center,
                          style: AppTheme.bodyText.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: AppColors.dangerDarkColor),
                        ),
                      )),
                  CountdownTimer(
                    controller: controller,
                    endTime: endTime,
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      return RichText(
                        text: TextSpan(
                          text: time == null ? "Belum dapet kode OTP? " : "",
                          style: GoogleFonts.poppins(
                              color: AppColors.primaryColorDarkColor),
                          children: <TextSpan>[
                            TextSpan(
                              text: time == null
                                  ? 'Kirim Lagi'
                                  : "${time.min ?? 0}:${time.sec}",
                              style: AppTheme.bodyText.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                                color: AppColors.primaryColorDarkColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (time == null) {
                                    // Make Request OTP Again
                                    resetCountDown();
                                    controller?.start();
                                  }
                                },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Buttons(
              disabled: !provider.enableButtonOtp,
              loading: provider.state == RequestState.Loading,
              title: "Lanjut",
              marginBottom: 0,
              onTap: () => _onLanjut(provider, params[1]),
            ),
          ],
        ),
      ),
    );
  }

  void closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _onLanjut(AuthProvider provider, String phoneNumber) {
    closeKeyboard();
    provider.smsCode = provider.otpCtrl.text;
    provider.signInUser().then((_) {
      if (provider.state == RequestState.Loaded) {
        const FlutterSecureStorage()
            .write(key: AppConst.PHONE_NUMBER_KEY, value: phoneNumber);
        Navigator.pushNamedAndRemoveUntil(
          context,
          BasePage.routeName,
          (route) => false,
        );
      } else {
        SnackBarCustom.showSnackBarMessage(
          context: context,
          title: "Opps!",
          message: provider.errMsg.toString(),
          typeMessage: SnackBarType.error,
        );
      }
    });
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
