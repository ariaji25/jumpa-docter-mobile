import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';

class CardFieldWidget extends StatelessWidget {
  final String keys;
  final String value;
  final BoxDecoration? styleBackground;
  final TextStyle? styleKey;
  final TextStyle? styleValue;

  const CardFieldWidget({
    Key? key,
    required this.keys,
    required this.value,
    this.styleBackground,
    this.styleKey,
    this.styleValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            keys,
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
}
