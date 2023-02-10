import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jd_mobile/common/resources/colors.dart';

class Loading extends StatelessWidget {
  final double size;
  final Color color;

  const Loading({Key? key, this.size = 30,this.color=AppColors.primaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitWave(
      color: color,
      size: size,
    ));
  }
}
