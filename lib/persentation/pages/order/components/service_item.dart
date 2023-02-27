import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';

class ServiceItem extends StatelessWidget {
  final String? title;
  final Function? onTap;
  final String? imagePath;
  final bool? isActive;

  const ServiceItem({
    Key? key,
    this.imagePath,
    this.isActive,
    this.onTap,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        decoration: BoxDecoration(
          color: isActive! ? AppColors.primaryColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: isActive!
                ? AppColors.primaryColor
                : const Color(
                    0xffA0AEC0,
                  ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "$imagePath",
              width: 40,
              color: isActive! ? AppColors.whiteColor : AppColors.primaryColor,
            ),
            Text(
              "$title",
              textAlign: TextAlign.center,
              style: AppTheme.subtitle.copyWith(
                fontSize: 12,
                color:
                    isActive! ? AppColors.whiteColor : AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
