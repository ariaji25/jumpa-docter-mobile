import 'package:flutter/material.dart';
import 'package:jd_mobile/common/extensions/padding_ext.dart';
import 'package:jd_mobile/common/theme/theme.dart';

class TextSubtitle extends StatelessWidget {
  const TextSubtitle({
    Key? key,
    required this.keys,
    required this.value,
  }) : super(key: key);

  final String? keys;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingOnly(left: 30),
      child: ListTile(
        minLeadingWidth: 10,
        leading: Text(
          "$keys",
          style: AppTheme.bodyText.copyWith(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
        title: Text(
          "$value",
          style: AppTheme.bodyText.copyWith(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
