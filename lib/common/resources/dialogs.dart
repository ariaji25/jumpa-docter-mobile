import 'package:flutter/material.dart';
import 'package:jd_mobile/common/extensions/padding_ext.dart';
import 'package:jd_mobile/common/extensions/context_ext.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/widgets/button_widget.dart';

class Dialogs {
  Dialogs._();

  static showDialogFeedback(BuildContext context) {
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
                  Assets.icStar,
                  width: 35.01,
                ),
                Image.asset(
                  Assets.icStar,
                  width: 50.01,
                ),
                Image.asset(
                  Assets.icStar,
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
              child: ButtonWidget(
                title: "Beri Masukan",
                onTap: () {},
              ),
            ),
            context.sbHeight(size: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: OutlineedButtonWidget(
                title: "Ingatkan Nanti",
                onTap: () {},
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

  static shoeDialogSuccesSendFeedback(BuildContext context) {
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
        height: 270,
        child: Column(
          children: [
            context.sbHeight(size: 40),
            Image.asset(
              Assets.icSuccess,
              width: 60,
            ),
            context.sbHeight(size: 13),
            Text(
              "Terima kasih sudah memberikan\nsaran dan masukan",
              textAlign: TextAlign.center,
              style: AppTheme.heading6.copyWith(
                color: Colors.black,
              ),
            ),
            context.sbHeight(size: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeConstants.margin,
              ),
              child: ButtonWidget(
                title: "Kembali ke Beranda",
                onTap: () {},
              ),
            ),
            context.sbHeight(size: 20),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
