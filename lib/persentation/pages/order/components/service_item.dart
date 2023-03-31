import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';

class ServiceItem extends StatelessWidget {
  final String? title;
  final Function? onTap;
  final String? imagePath;
  final bool? isActive;
  final double size;
  final double marginBottom;

  const ServiceItem(
      {Key? key,
      this.imagePath,
      this.isActive,
      this.onTap,
      this.title,
      this.size = 50,
      this.marginBottom = 8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 130,
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
              height: size,
              width: size,
              color: isActive! ? AppColors.whiteColor : AppColors.primaryColor,
            ),
            SizedBox(
              height: marginBottom,
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
