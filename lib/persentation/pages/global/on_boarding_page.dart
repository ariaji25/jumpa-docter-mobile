import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:jd_mobile/common/extensions/padding_ext.dart';
import 'package:jd_mobile/common/helpers/helpers.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/pages/auth/login_page.dart';
import 'package:jd_mobile/persentation/pages/global/components/provacy_policy.dart';
import 'package:jd_mobile/persentation/pages/global/components/term_and_conditions.dart';
import 'package:jd_mobile/persentation/widgets/app_bars.dart';
import 'package:jd_mobile/common/extensions/context_ext.dart';

class OnBoardingPage extends StatefulWidget {
  static const routeName = "/OnBoardingPage";

  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  List<String> images = [
    Assets.imgIls1,
    Assets.imgIls2,
    Assets.imgIls3,
  ];

  List<String> titles = [
    "Halo, Perkenalkan kami \nJumpaDokter",
    "Berobat ke dokter tanpa \nantri lama-lama",
    "Semoga \nlekas sembuh..."
  ];

  List<String> descriptions = [
    "Panggil dokter dari rumah dan lebih mudah dengan JumpaDokter",
    "Setelah kamu panggil dokter tenangkan diri biarkan kami para dokter menghampiri",
    "Jangan lupa istirahat yang cukup, minum air putih yang banyak dan minum obat",
  ];

  Widget _buildImage(String assetName) {
    return Container(
      padding: paddingOnly(
        left: 4.0,
        right: 4.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              assetName,
              height: MediaQuery.of(context).size.height / 4,
            ),
          ),
        ],
      ),
    );
  }

  PageDecoration pageDecoration = PageDecoration(
    titleTextStyle: AppTheme.bodyText.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryColor,
    ),
    bodyTextStyle: AppTheme.bodyText.copyWith(
      fontSize: 12.0,
      color: const Color(
        0XFF16192C,
      ),
    ),
    bodyPadding: const EdgeInsets.fromLTRB(
      15.0,
      0.0,
      15.0,
      0.0,
    ),
    pageColor: Colors.white,
    imagePadding: EdgeInsets.zero,
  );

  _createPages() {
    List<PageViewModel> pages = [];

    for (int i = 0; i < images.length; i++) {
      pages.add(PageViewModel(
        title: titles[i],
        body: descriptions[i],
        image: _buildImage(images[i]),
        decoration: pageDecoration,
      ));
    }
    return pages;
  }

  void _onIntroEnd(context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.routeName,
      (route) => false,
    );
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppsBar(
        elevation: 0.0,
        isWhite: true,
        title: Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: paddingOnly(
              left: 25.0,
              right: 25.0,
              top: Platform.isAndroid ? 12.0 : 0.0,
            ),
            child: SizedBox(
              height: 25,
              width: 74,
              child: Image.asset(Assets.logoSplash),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
        child: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          key: _introKey,
          pages: _createPages(),
          onDone: () => _onIntroEnd(context),
          showSkipButton: false,
          showDoneButton: false,
          showNextButton: false,
          globalFooter: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => _onIntroEnd(context),
                child: Container(
                  height: 47,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3869),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Masuk",
                      style: AppTheme.bodyText.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              context.sbHeight(size: 15),
              RichText(
                text: TextSpan(
                  text: "Dengan masuk dan mendaftar. kamu menyetujui",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: " Ketentuan layanan ",
                      style: AppTheme.bodyText.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.greyOtherColor,
                        fontSize: 12,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _showBottomSheetTermAndConditions(),
                    ),
                    const TextSpan(text: " dan "),
                    TextSpan(
                      text: "Kebijakan privasi.",
                      style: AppTheme.bodyText.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryColor,
                        fontSize: 12,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => _showBottomSheetPrivacyPolicyWidget(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          isBottomSafeArea: true,
          dotsDecorator: const DotsDecorator(
            size: Size(6.0, 6.0),
            color: Color(0xFFC4C4C4),
            activeColor: AppColors.primaryColor,
            activeSize: Size(6.0, 6.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }

  _showBottomSheetTermAndConditions() {
    return (BuildContext context) {
      return showModalBottomSheet(
        enableDrag: true,
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return const TermConditionWidget();
        },
      );
    };
  }

  _showBottomSheetPrivacyPolicyWidget(BuildContext context) {
    return showModalBottomSheet(
      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const PrivacyPolicyWidget();
      },
    );
  }
}
