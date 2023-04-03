import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final EdgeInsets? margin;
  final Widget leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;

  const ItemTile(
      {Key? key,
      this.margin,
      required this.leading,
      required this.title,
      this.subtitle,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leading,
              const SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  SizedBox(
                    height: subtitle == null ? 0 : 5,
                  ),
                  subtitle ?? const SizedBox()
                ],
              ),
            ],
          ),
          trailing ?? const SizedBox(),
        ],
      ),
    );
  }
}
