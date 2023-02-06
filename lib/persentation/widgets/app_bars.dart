import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jd_mobile/common/resources/colors.dart';

class AppsBar extends StatelessWidget with PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? title;
  final double? elevation;
  final FlexibleSpaceBar? flexibleSpaceBar;
  final RoundedRectangleBorder? rectangleBorder;
  final bool? isWhite;
  final Function()? onBackPressed;
  final PreferredSizeWidget? bottom;

  AppsBar({
    Key? key,
    this.actions,
    this.title,
    this.elevation = 4,
    this.flexibleSpaceBar,
    this.rectangleBorder,
    this.isWhite = false,
    this.onBackPressed,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: rectangleBorder,
      backgroundColor: isWhite! ? AppColors.whiteColor : AppColors.primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      flexibleSpace: flexibleSpaceBar,
      elevation: elevation,
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: 0,
      title: title,
      leading: onBackPressed != null
          ? Transform.translate(
              offset: const Offset(-7, 0),
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: onBackPressed,
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color:
                      isWhite! ? AppColors.primaryColor : AppColors.whiteColor,
                ),
              ),
            )
          : null,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight((Platform.isIOS) ? 60 : 70);
}
