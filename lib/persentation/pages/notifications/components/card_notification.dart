import 'package:flutter/material.dart';
import 'package:jd_mobile/common/extensions/context_ext.dart';

import '../../../../common/extensions/padding_ext.dart';
import '../../../../common/theme/theme.dart';

class CardNotificationWidget extends StatelessWidget {
  const CardNotificationWidget({
    Key? key,
    required this.iconPath,
    required this.label,
    required this.textColor,
    required this.backgroundColor,
  }) : super(key: key);

  final String iconPath;
  final String label;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingAll(10),
      margin: paddingBottom(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 20),
          context.sbWidth(size: 21),
          Expanded(
              child: Text(label,
                  style: AppTheme.bodyText.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: textColor)))
        ],
      ),
    );
  }
}
