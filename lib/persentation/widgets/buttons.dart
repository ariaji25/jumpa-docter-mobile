import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';

class Buttons extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool disabled;
  final bool loading;
  final double marginBottom;
  final double borderRadius;

  const Buttons({
    Key? key,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.disabled = false,
    this.marginBottom = 36,
    this.borderRadius = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled || loading ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: disabled
              ? AppColors.primaryColor.withOpacity(.50)
              : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        margin: EdgeInsets.only(bottom: marginBottom),
        height: 47,
        child: Center(
          child: loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.0,
                  ),
                )
              : Text(
                  title,
                  style: AppTheme.subtitle.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 12,
                  ),
                ),
        ),
      ),
    );
  }
}

class OutlineButtons extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool disabled;
  final bool loading;
  final double borderRadius;
  final double marginBottom;

  const OutlineButtons({
    Key? key,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.disabled = false,
    this.borderRadius = 6,
    this.marginBottom = 36,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(),
        ),
        margin: EdgeInsets.only(bottom: marginBottom),
        height: 47,
        child: Center(
          child: loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 2.0,
                  ),
                )
              : Text(
                  title,
                  style: AppTheme.subtitle.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                  ),
                ),
        ),
      ),
    );
  }
}

class ButtonCustom extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool disabled;
  final bool loading;
  final double marginBottom;
  final double borderRadius;
  final Color backgroundColor;
  final Color? borderColor;
  final TextStyle? titleStyle;
  final EdgeInsets? padding;
  final bool outline;

  const ButtonCustom(
      {Key? key,
      required this.title,
      required this.onTap,
      this.loading = false,
      this.disabled = false,
      this.marginBottom = 36,
      this.borderRadius = 6,
      this.backgroundColor = AppColors.primaryColor,
      this.borderColor,
      this.titleStyle,
      this.padding,
      this.outline = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: disabled ? backgroundColor.withOpacity(.50) : backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor ?? backgroundColor,
            width: 1,
          ),
        ),
        margin: EdgeInsets.only(bottom: marginBottom),
        padding: padding,
        child: Center(
          child: loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.0,
                  ),
                )
              : Text(
                  title,
                  style: titleStyle ??
                      AppTheme.subtitle.copyWith(
                        color: borderColor ?? AppColors.whiteColor,
                        fontSize: 12,
                      ),
                ),
        ),
      ),
    );
  }
}
