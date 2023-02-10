
import 'package:flutter/material.dart';

import '../../common/resources/assets.dart';
import '../../common/resources/colors.dart';

class LogoWidget {
  static Widget logoWhite = SizedBox(
    height: 29.62,
    width: 128,
    child: Image.asset(
      "${Assets.logoPath}/lg_white.png",
      color: AppColors.whiteColor,
    ),
  );

  static Widget logoIcon({double height=29.62,double width=128,Color color=AppColors.primaryColor}){
    return SizedBox(
      height:height,
      width: width,
      child: Image.asset(
        "${Assets.logoPath}/lg_white.png",
        color: color,
      ),
    );
  }
}