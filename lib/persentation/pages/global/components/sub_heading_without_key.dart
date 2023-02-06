import 'package:flutter/material.dart';
import 'package:jd_mobile/common/theme/theme.dart';

class TextSubHeadingsWithoutKeys extends StatelessWidget {
  const TextSubHeadingsWithoutKeys({
    Key? key,
    required this.value,
  }) : super(key: key);

  final String? value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
