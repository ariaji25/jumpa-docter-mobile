import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import '../../../common/extensions/padding_ext.dart';
import '../../../common/resources/assets.dart';
import '../../../common/resources/size.dart';
import '../../widgets/app_bars.dart';
import '../../widgets/logo_widget.dart';
import 'components/card_notification.dart';

class NotificationPage extends StatefulWidget {
  static const routeName = "/NotificationPage";

  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppsBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            LogoWidget.logoWhite
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.primaryColor, height: 1.0),
        ),
      ),
      body: Padding(
        padding: paddingAll(SizeConstants.margin),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              CardNotificationWidget(
                iconPath: "${Assets.iconsPath}/clock-history.png",
                label: "Dokter sedang dalam perjalanan",
                textColor: Color(0xff4AAE8C),
                backgroundColor: Color(0xffDEFFEE),
              ),
              CardNotificationWidget(
                iconPath: "${Assets.iconsPath}/calendar4.png",
                label:
                    "Jadwal temu dokter anda hari senin ya, jangan sampai lupa.",
                textColor: Color(0xffF1774A),
                backgroundColor: Color(0xffFFEDE3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
