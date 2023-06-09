import 'package:flutter/material.dart';

import '../../../../../common/theme/theme.dart';

class MenuDialog extends StatelessWidget {
  final String title;
  final String? subTitle;
  final VoidCallback onTap;

  const MenuDialog(
      {Key? key,
      required this.title,
      this.subTitle,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            title,
                            style: AppTheme.bodyText.copyWith(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )),
                      subTitle == null
                          ? Container()
                          : Text(
                              subTitle!,
                              style: AppTheme.bodyText.copyWith(
                                  color: const Color(0xFF999999),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic),
                            ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              color: const Color(0xFFEEEEEE),
              width: double.infinity,
              margin: const EdgeInsets.only(top: 5),
            )
          ],
        ),
      ),
    );
  }
}
