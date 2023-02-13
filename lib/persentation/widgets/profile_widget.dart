import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';

import '../../common/helpers/helpers.dart';
import '../../common/theme/theme.dart';

class ProfileInitialWidget extends StatelessWidget {
  final double size;
  final String name;
  final double fontSize;

  const ProfileInitialWidget(
      {Key? key, this.size = 50, this.name = "", this.fontSize = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: const Color(0XFFE4ECF7),
        child: Center(
            child: Text(
          Helpers.getInitials(name),
          style: AppTheme.bodyText.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize),
        )),
      ),
    );
  }
}
