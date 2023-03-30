import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:jd_mobile/common/theme/theme.dart';

Widget buildAlertPayment(String expiredDate) {
  return Container(
    width: double.infinity,
    height: 26,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: [
        const Icon(
          FeatherIcons.bell,
          color: Colors.red,
        ),
        const SizedBox(width: 12),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "Selesaikan pembayaran sebelum ",
                style: AppTheme.bodyText.copyWith(
                  color: Colors.red,
                  fontSize: 9,
                ),
              ),
              TextSpan(
                text: expiredDate,
                style: AppTheme.bodyText.copyWith(
                  color: Colors.red,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
