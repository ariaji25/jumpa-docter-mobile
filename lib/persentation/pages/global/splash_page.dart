import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/pages/global/on_boarding_page.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "/SplashPage";
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
    _initPackageInfo();
    _startSplashPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _introKey,
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                width: 169,
                height: 56,
                child: Image.asset(Assets.logoSplash),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: Text(
                _packageInfo.version,
                style: AppTheme.bodyText.copyWith(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _startSplashPage() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushNamed(context, OnBoardingPage.routeName);
    });
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
}
