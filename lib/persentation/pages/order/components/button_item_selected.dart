// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';

class ButtonItemSelect extends StatelessWidget {
  final String title;
  final Function onTap;
  bool isSelected = false;
  double borderRadius = 6;

  ButtonItemSelect({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isSelected,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              style: AppTheme.bodyText.copyWith(
                color:
                    isSelected ? AppColors.whiteColor : AppColors.primaryColor,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
