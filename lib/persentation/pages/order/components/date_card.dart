import 'package:flutter/material.dart';
import 'package:jd_mobile/common/extensions/date_time_ext.dart';

import '../../../../common/resources/colors.dart';
import '../../../../common/theme/theme.dart';

class DateCard extends StatelessWidget {
  final bool? isSelected;
  final double? width;
  final double? height;
  final DateTime? date;
  final Function? onTap;

  const DateCard(
    this.date, {
    Key? key,
    this.isSelected = false,
    this.width = 74,
    this.height = 92,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isSelected! ? AppColors.primaryColor : Colors.transparent,
          border: Border.all(
            color: isSelected! ? Colors.transparent : const Color(0xFFE4E4E4),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date!.day.toString(),
              style: AppTheme.subtitle.copyWith(
                color: isSelected! ? AppColors.whiteColor : AppColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              date!.monthName,
              style: AppTheme.subtitle.copyWith(
                color: isSelected! ? AppColors.whiteColor : AppColors.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              date!.dayName,
              style: AppTheme.subtitle.copyWith(
                color: isSelected! ? AppColors.whiteColor : AppColors.primaryColor,
                fontSize: 9,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
