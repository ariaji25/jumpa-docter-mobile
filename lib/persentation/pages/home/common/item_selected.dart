import 'package:flutter/material.dart';
import 'package:jd_mobile/common/theme/theme.dart';

import '../../../../common/extensions/padding_ext.dart';
import '../../../../common/resources/colors.dart';

class ItemSelected extends StatefulWidget {
  final String? title;
  final bool? isActive;
  final Function? onTap;

  const ItemSelected({
    Key? key,
    required this.isActive,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  State<ItemSelected> createState() => _ItemSelectedState();
}

class _ItemSelectedState extends State<ItemSelected> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        margin: paddingRight(20.0),
        child: Column(
          children: [
            Text(
              widget.title ?? "",
              style: AppTheme.subtitle.copyWith(
                color: widget.isActive!
                    ? AppColors.primaryColor
                    : AppColors.greyColor,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
