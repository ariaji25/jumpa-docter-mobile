import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/helpers/date_helper.dart';
import 'package:jd_mobile/common/helpers/helpers.dart';
import 'package:jd_mobile/common/resources/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../../common/extensions/padding_ext.dart';
import '../../../common/resources/assets.dart';
import '../../../common/resources/colors.dart';
import '../../../common/theme/theme.dart';
import '../../provider/order/order_provider.dart';
import '../../widgets/confirm_modal.dart';
import '../base/base_page.dart';
import 'components/base_screen_order.dart';
import 'components/card_field.dart';

class SummaryPage extends StatefulWidget {
  static const routeName = "/SummaryPage";
  final bool fromDetail;

  const SummaryPage({Key? key, this.fromDetail = false}) : super(key: key);

  @override
  SummaryPageState createState() => SummaryPageState();
}

class SummaryPageState extends State<SummaryPage> {
  ScreenshotController screenshotController = ScreenshotController();
  late OrderProvider orderProvider;

  @override
  void initState() {
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseOrderScreen(
      title: "Detail",
      subTitle: "Jadwal pesanan anda",
      onNext: _finish,
      btnTitle: widget.fromDetail ? "Tutup" : "Selesai",
      enableBackButton: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Screenshot(
            controller: screenshotController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Divider(
                  height: 1,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(height: 25),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildItemSummary(
                        key: "No Rekam Medis",
                        value: orderProvider.patientEntities.nrm ?? "-"),
                    _buildItemSummary(
                        key: "Nama pasien",
                        value: orderProvider.patientEntities.name ?? "-"),
                    _buildItemSummary(
                        key: "Layanan",
                        value: orderProvider.bookingEntities.service),
                    _buildItemSummary(
                      key: "Tanggal",
                      value: DateHelper.dateTimeToLocalDate(
                              orderProvider.bookingEntities.visitDate!)!
                          .replaceAll("-", "/"),
                    ),
                    _buildItemSummary(
                      key: "Jam",
                      value:
                          "${orderProvider.bookingEntities.visitTime} ${DateHelper.getTimezon()}",
                    ),
                    CardFieldWidget(
                      keys: "Biaya pemeriksaan",
                      value: orderProvider.bookingEntities.price!.isNotEmpty
                          ? Helpers.formatCurrency(
                              orderProvider.bookingEntities.price.toString())
                          : "",
                      styleBackground: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      styleKey: AppTheme.bodyText.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                      styleValue: AppTheme.bodyText.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Color(0XFFEF0C11),
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            "Biaya yang tercantum belum termasuk biaya tindakan dan obat",
                            style: AppTheme.bodyText.copyWith(
                                color: const Color(0XFFEF0C11), fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Icon(
                      FeatherIcons.mapPin,
                      color: AppColors.primaryColor,
                      size: 16,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Alamat Klinik",
                      style: AppTheme.bodyText.copyWith(
                          color: AppColors.primaryColorDarkColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      orderProvider.bookingEntities.clinicAddress ?? "",
                      style: AppTheme.bodyText.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25.0),
                    Text(
                      "Harap Datang  tepat waktu",
                      style: AppTheme.bodyText.copyWith(
                          color: const Color(0xFFF1774A),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Center(
            child: InkWell(
              onTap: () async {
                await _requestPermission();

                if (await Permission.storage.isGranted) {
                  screenshotController
                      .captureFromWidget(_struk())
                      .then((image) {
                    ImageGallerySaver.saveImage(image);
                    SnackBarCustom.showSnackBarMessage(
                        context: context,
                        title: "Menyimpan !",
                        message:
                            "Berhasil menyimpan detail pesanan, cek gallery-mu.",
                        typeMessage: SnackBarType.success);
                  }).catchError((onError) {
                    log(onError);
                  });
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                  border: Border.all(color: const Color(0XFFA0AEC0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_download_outlined,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 20.0),
                    Text(
                      "Download jadwal temu",
                      style: AppTheme.bodyText
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget queueWidget() {
    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: Text(
            "0",
            style: AppTheme.heading5.copyWith(color: AppColors.whiteColor),
          ),
        ),
      ),
    );
  }

  _requestPermission() async {
    await [Permission.storage].request();
  }

  Widget _struk() {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white,
            padding: paddingAll(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 33,
                          width: 100,
                          child: Image.asset("${Assets.logoPath}/logo.png"),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "Detail pesanan",
                          style: AppTheme.bodyText.copyWith(
                            fontSize: 36,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "No rekam medis",
                          style: AppTheme.bodyText.copyWith(
                            fontSize: 16,
                            color: AppColors.primaryColorDarkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: paddingTop(10.0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 25),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColorDarkColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Padding(
                              padding: paddingTop(2),
                              child: Text(
                                orderProvider.patientEntities.nrm ?? "",
                                textAlign: TextAlign.center,
                                style: AppTheme.heading6.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        _buildItemSummary(
                          key: "No Rekam Medis",
                          value: orderProvider.patientEntities.nrm ?? "",
                        ),
                        _buildItemSummary(
                          key: "Nama pasien",
                          value: orderProvider.patientEntities.name ?? "",
                        ),
                        _buildItemSummary(
                          key: "Layanan",
                          value: orderProvider.bookingEntities.service ?? "",
                        ),
                        _buildItemSummary(
                          key: "Tanggal",
                          value: orderProvider.bookingEntities.visitDate ?? "",
                        ),
                        _buildItemSummary(
                          key: "Jam",
                          value: orderProvider.bookingEntities.visitTime ?? "",
                        ),
                        CardFieldWidget(
                          keys: "Biaya pemeriksaan",
                          value: orderProvider.bookingEntities.price!.isNotEmpty
                              ? Helpers.formatCurrency(orderProvider
                                  .bookingEntities.price
                                  .toString())
                              : "",
                          styleBackground: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          styleKey: AppTheme.bodyText.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          styleValue: AppTheme.bodyText.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Color(0XFFEF0C11),
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                "Biaya yang tercantum belum termasuk biaya tindakan dan obat",
                                style: AppTheme.bodyText.copyWith(
                                    color: const Color(0XFFEF0C11),
                                    fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  const Icon(
                    FeatherIcons.mapPin,
                    color: AppColors.primaryColor,
                    size: 16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Alamat Klinik",
                    style: AppTheme.bodyText.copyWith(
                        color: AppColors.primaryColorDarkColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    orderProvider.bookingEntities.clinicAddress ?? "",
                    style: AppTheme.bodyText.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25.0),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 25),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEDE3),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xFFF1774A),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: paddingRight(16.0),
                                child: const Icon(
                                  Icons.info_outline,
                                  color: Color(0xFFF1774A),
                                  size: 16,
                                ),
                              ),
                              Text(
                                'Harap Datang Tepat Waktu',
                                textAlign: TextAlign.center,
                                style: AppTheme.bodyText.copyWith(
                                  color: const Color(0xFFF1774A),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemSummary({required String key, String? value}) {
    return Column(
      children: [
        CardFieldWidget(
          keys: key,
          styleBackground: BoxDecoration(
            color: AppColors.grey200Color,
            borderRadius: BorderRadius.circular(3),
          ),
          styleKey: AppTheme.bodyText.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 12),
          styleValue: AppTheme.bodyText.copyWith(
              color: AppColors.primaryColorDarkColor,
              fontWeight: FontWeight.w500,
              fontSize: 12),
          value: value ?? "",
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  _finish() async {
    if (widget.fromDetail) {
      Navigator.of(context).pop();
    } else {
      orderProvider.clear();
      const storage = FlutterSecureStorage();
      Navigator.pushNamed(context, BasePage.routeName, arguments: 2);
      String isOpenFeedback =
          await storage.read(key: AppConst.OPEN_FEEDBACK_KEY) ?? 'false';
      if ((isOpenFeedback.toLowerCase() == "true")) {
        if (mounted) {
          Alerts.showAlertDialogFeedback(context);
        }
        await storage.write(
            key: AppConst.OPEN_FEEDBACK_KEY, value: false.toString());
      }
    }
  }
}
