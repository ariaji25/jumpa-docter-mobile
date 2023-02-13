import 'package:flutter/material.dart';
import 'package:jd_mobile/common/extensions/context_ext.dart';
import 'package:jd_mobile/persentation/pages/base/base_page.dart';

import '../../common/extensions/padding_ext.dart';
import '../../common/resources/assets.dart';
import '../../common/resources/colors.dart';
import '../../common/resources/size.dart';
import '../../common/theme/theme.dart';
import '../pages/feedback/feedback_page.dart';
import 'buttons.dart';

void confirmModal(
  BuildContext context,
  String title,
  String msg, {
  Function()? onOk,
  Function()? onCancel,
  String? okText,
  String? cancelText,
  bool isOne = false,
}) {
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            title,
          ),
          content: Text(
            msg,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                if (onCancel != null) {
                  onCancel();
                }
              },
              child: Text(
                cancelText ?? 'Tidak',
              ),
            ),
            !isOne
                ? TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      if (onOk != null) {
                        onOk();
                      }
                    },
                    child: Text(
                      okText ?? 'Ya',
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      });
}

class Alerts {
  static showAlertDialogFeedback(BuildContext context) {
    Widget alert = AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      insetPadding: const EdgeInsets.all(SizeConstants.margin),
      contentPadding: paddingAll(0.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: Column(
          children: [
            /// STARS
            context.sbHeight(size: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  "${Assets.iconsPath}/ic_stars.png",
                  width: 35.01,
                ),
                Image.asset(
                  "${Assets.iconsPath}/ic_stars.png",
                  width: 50.01,
                ),
                Image.asset(
                  "${Assets.iconsPath}/ic_stars.png",
                  width: 35.01,
                ),
              ],
            ),
            context.sbHeight(size: 13),
            Text(
              "Berikan kami masukan untuk lebih\nbaik lagi",
              textAlign: TextAlign.center,
              style: AppTheme.subtitle.copyWith(
                color: Colors.black,
              ),
            ),
            context.sbHeight(size: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: Buttons(
                title: "Beri Masukan",
                borderRadius: 6,
                onTap: () {
                  Navigator.pushNamed(context, FeedbackPage.routeName);
                },
                marginBottom: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: OutlineButtons(
                marginBottom: 0,
                title: "Ingatkan Nanti",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showAlertDialogExsistingAccount(BuildContext context) {
    Widget alert = AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      insetPadding: const EdgeInsets.all(SizeConstants.margin),
      contentPadding: paddingAll(0.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.primaryColorDarkColor,
                      ),
                    ),
                  ),
                  context.sbHeight(size: 5),
                  Image.asset(
                    "${Assets.iconsPath}/handphone.png",
                    width: 60,
                    height: 107,
                  ),
                  context.sbHeight(size: 13),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          "No hp yang anda daftarkan sudah terdaftar sebelumnya, silahkan cek pada ",
                      style: AppTheme.bodyText.copyWith(
                        color: AppColors.primaryColorDarkColor,
                        fontSize: 13,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '"Pasien sudah terdaftar"',
                          style: AppTheme.bodyText.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: AppColors.primaryColorDarkColor),
                        ),
                      ],
                    ),
                  ),
                  context.sbHeight(size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showAlertDialogSuccess(BuildContext context) {
    Widget alert = AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      insetPadding: const EdgeInsets.all(SizeConstants.margin),
      contentPadding: paddingAll(0.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 245,
        child: Column(
          children: [
            context.sbHeight(size: 40),
            Image.asset(
              "${Assets.iconsPath}/ic_success.png",
              width: 60,
            ),
            context.sbHeight(size: 13),
            Text(
              "Terima kasih sudah memberikan\nsaran dan masukan",
              textAlign: TextAlign.center,
              style: AppTheme.subtitle.copyWith(
                color: Colors.black,
              ),
            ),
            context.sbHeight(size: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: Buttons(
                title: "Kembali ke Beranda",
                borderRadius: 6,
                onTap: () {
                  Navigator.pushNamed(context, BasePage.routeName);
                },
                marginBottom: 5,
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
