import 'package:flutter/material.dart';

import '../../../../common/resources/colors.dart';
import '../../../../common/theme/theme.dart';

Widget buildCardPrice(String price) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColors.grey200Color,
      borderRadius: BorderRadius.circular(3),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Total yang harus dibayar",
          style: AppTheme.bodyText.copyWith(
              fontSize: 12,
              color: AppColors.primaryColorDarkColor,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          price,
          style: AppTheme.bodyText.copyWith(
            fontSize: 12,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
