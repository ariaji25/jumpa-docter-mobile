import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/domain/entities/patient/attribute_entities.dart';
import 'package:jd_mobile/persentation/pages/feedback/feedback_page.dart';
import 'package:jd_mobile/persentation/provider/patient/patient_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/theme.dart';
import '../../widgets/confirm_modal.dart';
import '../../widgets/privacy_policy.dart';
import '../../widgets/profile_widget.dart';
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PatientProvider patientProvider =
          Provider.of<PatientProvider>(context, listen: false);
      patientProvider.setNrmPatient(patientProvider
          .detailPatient.trackedEntityInstances?[0].attributes
          ?.firstWhere((element) => element.attribute == "kOJUHSrbkBS",
              orElse: () => AttributesEntities(value: "---------"))
          .value??"-");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PatientProvider patientProvider =
        Provider.of<PatientProvider>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(patientProvider),
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

  Widget _buildHeader(PatientProvider patientProvider) {
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
                child: ProfileInitialWidget(
                  size: 90,
                  name: patientProvider.patient.name ?? "",
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                patientProvider.patient.name ?? "-",
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
                patientProvider.nrmPatient ?? "-",
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
                    width: 16,
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
