import 'package:flutter/material.dart';

import '../../../../common/resources/colors.dart';
import '../../../../common/resources/size.dart';
import '../../../../common/theme/theme.dart';

Widget cardColumn(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          style: AppTheme.subtitle.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.primaryColorDarkColor,
          ),
        ),
        Text(
          value,
          style: AppTheme.subtitle.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              fontSize: 12),
        ),
        const SizedBox(height: 10)
      ],
    ),
  );
}

Widget cardTile(String key, String value,
    {bool isBold = false, double fontSize = 10}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        key,
        style: AppTheme.subtitle.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: fontSize),
      ),
      Text(
        value,
        style: AppTheme.subtitle.copyWith(
            color: AppColors.primaryColor,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w500,
            fontSize: fontSize),
      ),
    ],
  );
}
