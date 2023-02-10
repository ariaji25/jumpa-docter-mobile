import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';

import '../../../../common/theme/theme.dart';

class ItemFileAttach extends StatelessWidget {
  final String? title;
  final Color? colors;
  final Function? onTap;
  final String? imagePath;
  final double? size;
  final bool showBadge;
  final TextStyle? titleStyle;

  const ItemFileAttach({
    Key? key,
    required this.colors,
    required this.imagePath,
    required this.onTap,
    required this.title,
    this.size = 47,
    this.showBadge = false,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              imagePath ?? "",
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title ?? "",
            textAlign: TextAlign.center,
            style: titleStyle ??
                AppTheme.bodyText.copyWith(
                  color: AppColors.primaryColorDarkColor,
                  fontSize: 12,
                ),
          )
        ],
      ),
    );
  }
}
