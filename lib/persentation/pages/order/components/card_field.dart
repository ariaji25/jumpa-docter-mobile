import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import '../../../../common/extensions/padding_ext.dart';
import '../../../../common/theme/theme.dart';

Widget cardFieldWidget(
    {required String key, required String value, bool isBg = false}) {
  return Container(
    padding: paddingAll(15),
    margin: const EdgeInsets.only(top: 4),
    decoration: BoxDecoration(
      color: isBg ? AppColors.primaryColor : const Color(0xffF8F8F8),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: AppTheme.bodyText.copyWith(
            color: isBg ? const Color(0xffF8F8F8) : AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: AppTheme.bodyText.copyWith(
            color: isBg ? const Color(0xffF8F8F8) : AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget cardFieldCustomWidget(
    {required String key,
    required String value,
    BoxDecoration? styleBackground,
    TextStyle? styleKey,
    TextStyle? styleValue}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
    decoration: styleBackground ??
        BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(3),
        ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: styleKey ??
              AppTheme.bodyText.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          value,
          style: styleValue ??
              AppTheme.bodyText.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    ),
  );
}
