import 'package:flutter/material.dart';

import '../../common/resources/colors.dart';
import '../../common/theme/theme.dart';

Widget buttonItemSelected(
    {required String title,
    required Function onTap,
    bool isSelected = false,
    double borderRadius = 6}) {
  return Expanded(
    flex: 1,
    child: InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.greyColor,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Text(
            title,
            style: AppTheme.subtitle.copyWith(
                color:
                    isSelected ? AppColors.whiteColor : AppColors.primaryColor,
                fontSize: 12),
          ),
        ),
      ),
    ),
  );
}
