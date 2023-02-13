import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';

import '../../common/resources/assets.dart';
import '../../common/theme/theme.dart';
import 'buttons.dart';

Widget universalEmptyState(
    {String? label,
    String? labelButton,
    Function? onTap,
    bool withLogo = false}) {
  return Center(
    child: Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Visibility(
          visible: withLogo,
          child: Image.asset(
            "${Assets.logoPath}/logo.png",
            height: 33,
            width: 99,
          ),
        ),
        Visibility(
          visible: withLogo,
          child: const SizedBox(
            height: 10,
          ),
        ),
        Image.asset(
          "${Assets.othersPath}/empty_state.png",
          width: 230,
          height: 153,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          label ?? "Data tidak ditemukan/kosong",
          style: AppTheme.subtitle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor),
        ),
        const SizedBox(
          height: 30,
        ),
        Visibility(
          visible: labelButton != null,
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
            child: Buttons(
              title: labelButton ?? "Kembali ke menu utama",
              onTap: onTap == null ? () {} : onTap(),
              borderRadius: 6,
            ),
          ),
        ),
      ],
    ),
  );
}
