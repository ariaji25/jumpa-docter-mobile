import 'package:flutter/material.dart';
import 'package:jd_mobile/common/theme/theme.dart';

class TextSubHeadings extends StatelessWidget {
  const TextSubHeadings({
    Key? key,
    required this.keys,
    required this.value,
  }) : super(key: key);

  final String? keys;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
