import 'package:flutter/material.dart';
import 'package:jd_mobile/common/theme/theme.dart';

class TextHeadings extends StatelessWidget {
  const TextHeadings({
    Key? key,
    required this.keys,
    required this.value,
  }) : super(key: key);

  final String? keys;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$keys. $value",
      style: AppTheme.bodyText.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
    );
  }
}
