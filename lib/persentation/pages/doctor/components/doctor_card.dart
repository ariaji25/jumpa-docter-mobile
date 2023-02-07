import 'package:flutter/material.dart';
import 'package:jd_mobile/common/extensions/context_ext.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';

class DoctorCard extends StatelessWidget {
  static const double itemHeight = 181;
  static const double itemWidth = 145;

  final String? imagePath;
  final String? name;
  final String? docterType;
  final Function onTap;

  const DoctorCard({
    Key? key,
    this.docterType,
    this.imagePath,
    this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: itemWidth,
        height: itemHeight,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0XFFE4ECF7),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null && imagePath != "")
              Image.network(
                imagePath!,
                width: 73,
              ),
            if (imagePath == null || imagePath == "")
              Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  Assets.imgIlsDoctor,
                  width: double.infinity,
                ),
              ),
            Text(
              name ?? "-",
              textAlign: TextAlign.center,
              style: AppTheme.subtitle.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            Text(
              docterType ?? "-",
              textAlign: TextAlign.center,
              style: AppTheme.subtitle.copyWith(
                fontSize: 12,
                color: AppColors.primaryColorDarkColor,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
