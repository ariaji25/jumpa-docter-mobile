import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';

import '../../common/theme/theme.dart';

class MenuItems extends StatefulWidget {
  final String? title;
  final Color? colors;
  final Function? onTap;
  final String? imagePath;
  final double? size;
  final bool showBadge;
  final TextStyle? titleStyle;

  const MenuItems({
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
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap!();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Container(
                  height: widget.size,
                  width: widget.size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    widget.imagePath ?? "",
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Text(
                    widget.title ?? "",
                    textAlign: TextAlign.center,
                    style: widget.titleStyle ??
                        AppTheme.subtitle.copyWith(
                          color: AppColors.primaryColorDarkColor,
                          fontSize: 12,
                        ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: widget.showBadge,
            child: Positioned(
              top: 0,
              right: 0,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  decoration: BoxDecoration(
                      color: const Color(0XFFEF0C11),
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    "Baru",
                    style: AppTheme.subtitle
                        .copyWith(fontSize: 8, color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
