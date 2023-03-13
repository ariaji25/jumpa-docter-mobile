import 'package:flutter/material.dart';

import '../../../../common/extensions/padding_ext.dart';
import '../../../../common/resources/assets.dart';
import '../../../../common/resources/colors.dart';
import '../../../../common/theme/theme.dart';

Widget searchButton(
    {required String label, String? value, required Function() onTap}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: AppTheme.subtitle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColorDarkColor,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(width: 1, color: AppColors.primaryColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: paddingLeft(7.0),
                child: Text(
                  value != null && value.isNotEmpty ? value : 'Pilih',
                  style: AppTheme.bodyText.copyWith(color: Colors.black),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColors.primaryColor,
                size: 16,
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class DoctorItem extends StatelessWidget {
  final bool? isActive;
  final Function? onTap;

  const DoctorItem({
    Key? key,
    this.isActive,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width / 2.5,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isActive! ? AppColors.primaryColor : AppColors.whiteColor,
          border: Border.all(),
        ),
        child: Row(
          children: [
            Image.asset("${Assets.othersPath}/doctor.png"),
            Expanded(
              child: Text(
                "dr. Rommy Kurniawan Desky",
                style: AppTheme.subtitle.copyWith(
                  color:
                      isActive! ? AppColors.whiteColor : AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
              color:
                  isActive! ? AppColors.primaryColor : const Color(0xffA0AEC0)),
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

Widget loadingWidget = const SizedBox(
  width: 20,
  height: 20,
  child: CircularProgressIndicator(
    color: AppColors.primaryColor,
    strokeWidth: 2.0,
  ),
);
