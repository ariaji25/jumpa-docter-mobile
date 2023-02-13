// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/pages/account/profile_page.dart';
import 'package:jd_mobile/persentation/pages/chat/chat_page.dart';
import 'package:jd_mobile/persentation/pages/home/home_page.dart';
import 'package:jd_mobile/persentation/provider/auth/auth_provider.dart';
import 'package:jd_mobile/persentation/widgets/logo_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_const.dart';
import '../../../common/extensions/context_ext.dart';
import '../../../common/extensions/padding_ext.dart';
import '../../../common/resources/assets.dart';
import '../../../common/resources/colors.dart';
import '../../../common/resources/size.dart';
import '../../../common/resources/snackbar.dart';
import '../../../data/datasources/http_services.dart';
import '../../provider/patient/patient_provider.dart';
import '../../widgets/app_bars.dart';
import '../../widgets/confirm_modal.dart';
import '../../widgets/profile_widget.dart';
import '../account/profile_form.dart';
import '../auth/login_page.dart';
import 'package:jd_mobile/injection.dart' as di;

class BasePage extends StatefulWidget {
  static const routeName = "/BasePage";

  const BasePage({Key? key}) : super(key: key);

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState extends State<BasePage> {
  int _currentIndex = 0;
  final _screens = [
    const HomePage(),
    const ChatPage(),
    const HomePage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PatientProvider patientProvider =
          Provider.of<PatientProvider>(context, listen: false);
      Future.delayed(const Duration(milliseconds: 300), () async {
        String token =
            await const FlutterSecureStorage().read(key: AppConst.AUTH_TOKEN) ??
                "";
        di.getIt<HttpService>().setToken(token: token);
        await patientProvider.patientDetailByNrm();
        isInvalidToken(context, patientProvider);
        isNewPatient(context, patientProvider);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    PatientProvider patientProvider =
        Provider.of<PatientProvider>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_currentIndex != 0 ? 90 : 150),
        child: AppsBar(
          rectangleBorder: const RoundedRectangleBorder(),
          elevation: 0,
          flexibleSpaceBar: FlexibleSpaceBar(
            centerTitle: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: paddingOnly(top: 40.0),
                        child: LogoWidget.logoWhite,
                      ),

                      /// APPBAR ITEMS
                      if (_currentIndex != 3)
                        Padding(
                          padding: paddingOnly(top: 40.0, right: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                patientProvider.isNewPatient
                                    ? "👋Hi"
                                    : "👋Hi, ${patientProvider.patient.name}",
                                style: AppTheme.subtitle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    LoginPage.routeName,
                                    (route) => false,
                                  );
                                },
                                onDoubleTap: () {
                                  // if (F.appFlavor == Flavor.DEV) {
                                  //   alice.showInspector();
                                  // }
                                },
                                child: ProfileInitialWidget(
                                  size: 30,
                                  name: patientProvider.patient.name ?? "",
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _currentIndex == 0,
                  child: context.sbHeight(size: 23),
                ),
                Visibility(
                  visible: _currentIndex == 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConstants.margin),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginPage.routeName,
                                (route) => false,
                              );
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.primaryColorDarkColor
                                    .withOpacity(0.4),
                              ),
                              child: Row(
                                children: [
                                  context.sbWidth(size: 5),
                                  const Icon(
                                    FeatherIcons.search,
                                    color: Color(0XFF718096),
                                    size: 20,
                                  ),
                                  context.sbWidth(size: 10),
                                  Text(
                                    "Cari dokter",
                                    style: AppTheme.bodyText.copyWith(
                                        color: const Color(0XFF718096)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        context.sbWidth(size: 11),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginPage.routeName,
                              (route) => false,
                            );
                          },
                          child: Container(
                            width: 50,
                            height: 47,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColorDarkColor
                                  .withOpacity(0.4),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              FeatherIcons.bell,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 0,
              blurRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _updateIndex,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: const Color(0XFFA0AEC0),
          selectedFontSize: 13,
          unselectedFontSize: 13,
          iconSize: 30,
          backgroundColor: AppColors.whiteColor,
          items: [
            BottomNavigationBarItem(
              label: "Beranda",
              activeIcon: SvgPicture.asset(
                "${Assets.iconsPath}/house.svg",
                width: 20,
                height: 20,
                color: AppColors.primaryColor,
              ),
              icon: SvgPicture.asset(
                "${Assets.iconsPath}/house.svg",
                width: 20,
                height: 20,
                color: const Color(0XFFA0AEC0),
              ),
            ),
            BottomNavigationBarItem(
              label: "Pesan",
              activeIcon: SvgPicture.asset("${Assets.iconsPath}/chat.svg",
                  width: 20, height: 20, color: AppColors.primaryColor),
              icon: SvgPicture.asset("${Assets.iconsPath}/chat.svg",
                  width: 20, height: 20, color: const Color(0XFFA0AEC0)),
            ),
            BottomNavigationBarItem(
              label: "Janji Temu",
              activeIcon: SvgPicture.asset(
                "${Assets.iconsPath}/cart.svg",
                width: 20,
                height: 20,
                color: AppColors.primaryColor,
              ),
              icon: SvgPicture.asset("${Assets.iconsPath}/cart.svg",
                  width: 20, height: 20, color: const Color(0XFFA0AEC0)),
            ),
            const BottomNavigationBarItem(
              label: "Profil",
              activeIcon: Icon(
                FeatherIcons.user,
                size: 20,
              ),
              icon: Icon(
                FeatherIcons.user,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  void isNewPatient(BuildContext context, PatientProvider patientProvider) {
    if (patientProvider.isNewPatient && !patientProvider.isInvalidToken) {
      confirmModal(
        context,
        "Pasien Baru",
        "Selamat datang di JumpaDokter. \nKami tidak menemukan 'Rekam Medis' anda, lengkapi sekarang?",
        onOk: () {
          Navigator.pushNamed(context, ProfileForm.routeName);
        },
        okText: "Sekarang",
        cancelText: "Nanti",
      );
    }
  }

  void isInvalidToken(
      BuildContext context, PatientProvider patientProvider) async {
    if (patientProvider.isInvalidToken) {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      await authProvider.logout().then((value) {
        /// SET VALUE IS IN VALID TOKEN TO FALSE AGAIN
        patientProvider.setIsInvalidToken(false);

        Navigator.of(context).pushNamedAndRemoveUntil(
            LoginPage.routeName, (Route<dynamic> route) => false);
        SnackBarCustom.showSnackBarMessage(
            context: context,
            title: "Opps! ",
            message: "Sesi anda telah habis, silahkan login kembali!",
            typeMessage: SnackBarType.error);
      });
    }
  }
}
