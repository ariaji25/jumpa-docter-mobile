import 'package:flutter/material.dart';
import 'package:jd_mobile/common/extensions/padding_ext.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/common/resources/snackbar.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/pages/auth/components/help_bottom_sheet.dart';
import 'package:jd_mobile/persentation/pages/auth/otp_page.dart';
import 'package:jd_mobile/persentation/pages/global/on_boarding_page.dart';
import 'package:jd_mobile/persentation/widgets/app_bars.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/LoginPage";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _noHpCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Masuk dengan nomor HP yang terhubung Whatsapp",
              style: AppTheme.bodyText.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 35),
            Text(
              "Nomor Whatsapp",
              style: AppTheme.bodyText.copyWith(
                color: AppColors.primaryColorLightColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _noHpCtrl,
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

  void _onNext() {
    if (_noHpCtrl.text.isEmpty) {
      SnackBarCustom.showSnackBarMessage(
        context:context,
        title: "Ops!",
        message: "Silahkan mengisi nomor hp terlebih dahulu!",
        typeMessage: SnackBarType.error
      );
    } else {
      Navigator.pushNamed(context, OtpPage.routeName);
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
