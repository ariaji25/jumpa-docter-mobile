import 'package:flutter/material.dart';
import 'package:jd_mobile/common/extensions/padding_ext.dart';
import 'package:jd_mobile/common/helpers/phone_number_helper.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/common/resources/snackbar.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/persentation/pages/auth/components/help_bottom_sheet.dart';
import 'package:jd_mobile/persentation/pages/auth/otp_page.dart';
import 'package:jd_mobile/persentation/pages/global/on_boarding_page.dart';
import 'package:jd_mobile/persentation/provider/auth/auth_provider.dart';
import 'package:jd_mobile/persentation/widgets/app_bars.dart';
import 'package:provider/provider.dart';

import '../../../common/helpers/error_auth_helper.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/LoginPage";

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumber = TextEditingController();

  _navigateToOtpPage(String phoneNumber, String verificationId) {
    Navigator.pushNamed(
      context,
      OtpPage.routeName,
      arguments: [verificationId, phoneNumber],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppsBar(
        elevation: 0,
        isWhite: true,
        title: Padding(
          padding: paddingOnly(left: 16.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: paddingTop(SizeConstants.margin),
                child: IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        OnBoardingPage.routeName,
                        (route) => false,
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: paddingTop(20.0),
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
              "Masuk",
              style: AppTheme.bodyText.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            Text(
              "Masuk dengan nomor HP yang terhubung",
              style: AppTheme.bodyText.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 35),
            Text(
              "Nomor HP",
              style: AppTheme.bodyText.copyWith(
                color: AppColors.primaryColorLightColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _phoneNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "cth : 08123456789",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () => _bottomSheetHelp(context),
              child: Text(
                "Terjadi kendala dengan nomor HP mu?",
                style: AppTheme.subtitle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryColor,
                  decorationThickness: 2,
                  shadows: [
                    const Shadow(
                      color: AppColors.primaryColor,
                      offset: Offset(0, -3),
                    )
                  ],
                  color: Colors.transparent,
                ),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () => _onLanjut(provider, _phoneNumber.text),
              child: Container(
                height: 47,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: provider.requestState == RequestState.Loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        )
                      : Text(
                          "Lanjut",
                          style: AppTheme.subtitle.copyWith(
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

  void closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _onLanjut(AuthProvider provider, String phoneNumber) {
    if (_phoneNumber.text.isEmpty) {
      closeKeyboard();
      SnackBarCustom.showSnackBarMessage(
        context: context,
        title: "Ops!",
        message: "Silahkan mengisi nomor hp terlebih dahulu!",
        typeMessage: SnackBarType.error,
      );
    } else {
      provider.setRequestState(RequestState.Loading);
      provider.requestOtp(
        phoneNumber: PhoneNumberHelper.formatPhoneNumber(_phoneNumber.text),
        timeout: const Duration(seconds: 120),
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (err) {
          provider.setRequestState(RequestState.Error);
          SnackBarCustom.showSnackBarMessage(
            context: context,
            title: "Opps!",
            message: ErrorAuthHelper.getAuthErrorMessage(err),
            typeMessage: SnackBarType.error,
          );
        },
        codeSent: (verificationId, resendToken) async {
          provider.verificationId = verificationId;
          provider.resendToken = resendToken;
          await _navigateToOtpPage(
            _phoneNumber.text,
            verificationId,
          );
          provider.setRequestState(RequestState.Loaded);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          provider.verificationId = verificationId;
          provider.setRequestState(RequestState.Error);
        },
      );
    }
  }

  _bottomSheetHelp(BuildContext context) {
    return showModalBottomSheet(
      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const Help();
      },
    );
  }
}
