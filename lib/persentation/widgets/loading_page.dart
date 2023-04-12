import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jd_mobile/common/resources/colors.dart';

class LoadingPage extends StatelessWidget {
  static const routeName = "/Loading";
  final double size;
  final Color color;

  const LoadingPage({Key? key, this.size = 30,this.color=AppColors.primaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Center(
          child: SpinKitWave(
        color: color,
        size: size,
      )),
    );
  }
}
