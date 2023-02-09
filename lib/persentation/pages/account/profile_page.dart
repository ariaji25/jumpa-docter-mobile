import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/persentation/pages/feedback/feedback_page.dart';

import '../../../common/theme/theme.dart';
import '../../widgets/confirm_modal.dart';
import '../../widgets/privacy_policy.dart';
import '../../widgets/term_and_condition.dart';
import '../auth/login_page.dart';
import 'about_page.dart';
import 'profile_form.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String? _nrmPatient;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      //GET DATA NRM PASIEN
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 25),
            _menuItems(
              assets: "${Assets.iconsPath}/person.png",
              key: "Identitas pasien",
              onTap: () {
                Navigator.pushNamed(context, ProfileForm.routeName);
              },
            ),
            const SizedBox(height: 25),
            _menuItems(
              assets: "${Assets.iconsPath}/gear.png",
              key: "Pengaturan",
              onTap: () {},
            ),
            const SizedBox(height: 25),
            _menuItems(
              assets: "${Assets.iconsPath}/clipboard-check.png",
              key: "Syarat dan ketentuan",
              onTap: () {
                bottomSheetTermAndConditionWidget(context);
              },
            ),
            const SizedBox(height: 25),
            _menuItems(
              assets: "${Assets.iconsPath}/shield-lock.png",
              key: "Kebijakan dan privasi",
              onTap: () {
                bottomSheetPrivacyPolicyWidget(context);
              },
            ),
            const SizedBox(height: 25),
            _menuItems(
              assets: "${Assets.iconsPath}/patch-exclamation.png",
              key: "Tentang",
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
            ),
            const SizedBox(height: 25),
            _menuItems(
              assets: "${Assets.iconsPath}/hand-thumbs-up.png",
              key: "Kritik dan saran",
              onTap: () {
                Navigator.pushNamed(context, FeedbackPage.routeName);
              },
            ),
            const SizedBox(height: 25),
            _menuItems(
              assets: "${Assets.iconsPath}/box-arrow-right.png",
              key: "Keluar",
              isLogout: true,
              onTap: () => _onLogout(context),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  void _onLogout(BuildContext context) {
    confirmModal(
      context,
      "Keluar",
      "Yakin ingin keluar?",
      onOk: () async {
        //SERVICE LOGOUT
        Navigator.of(context).pushNamedAndRemoveUntil(
            LoginPage.routeName, (Route<dynamic> route) => false);
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 221,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Image.asset(
            "${Assets.othersPath}/bg.png",
            height: 221,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  color: Colors.transparent,
                  child: const Icon(
                    Icons.account_circle,
                    size: 90,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                "-",
                style: AppTheme.heading6.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "No rekam medis",
                style: AppTheme.heading6.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              Text(
                _nrmPatient.toString(),
                style: AppTheme.heading6.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _menuItems({
    String? assets,
    IconData? icons,
    bool isLogout = false,
    required String key,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
        child: Row(
          children: [
            assets != null
                ? Image.asset(
                    assets,
                    width: 12,
                    color: isLogout ? Colors.red : null,
                  )
                : Icon(
                    icons,
                    color: isLogout ? Colors.red : AppColors.primaryColor,
                  ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                key,
                style: AppTheme.subtitle.copyWith(
                    color: isLogout ? Colors.red : AppColors.primaryColor,
                    fontSize: 14),
              ),
            ),
            Visibility(
              visible: !isLogout,
              child: const Icon(Icons.chevron_right),
            )
          ],
        ),
      ),
    );
  }
}
