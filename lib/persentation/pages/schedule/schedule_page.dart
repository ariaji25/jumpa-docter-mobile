import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jd_mobile/common/extensions/context_ext.dart';
import 'package:jd_mobile/common/extensions/entities_ext.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/domain/entities/patient/event_entities.dart';
import 'package:jd_mobile/persentation/pages/webview/webview_page.dart';
import 'package:jd_mobile/persentation/provider/patient/patient_provider.dart';
import 'package:jd_mobile/persentation/provider/schedule/schedule_provider.dart';
import 'package:jd_mobile/persentation/widgets/loading.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_const.dart';
import '../../../common/extensions/padding_ext.dart';
import '../../../common/resources/assets.dart';
import '../../../common/resources/colors.dart';
import '../../../common/resources/size.dart';
import '../../../common/resources/snackbar.dart';
import '../../../common/theme/theme.dart';
import '../../widgets/buttons.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  bool segmentedControlValue = true;

  @override
  void initState() {
    _getEnrollmentOrHistory();
    initializeDateFormatting();
    super.initState();
  }

  _getEnrollmentOrHistory() {
    Future.delayed(const Duration(seconds: 0), () async {
      PatientProvider patientProvider =
          Provider.of<PatientProvider>(context, listen: false);
      ScheduleProvider scheduleProvider =
          Provider.of<ScheduleProvider>(context, listen: false);
      await scheduleProvider
          .getListEnrollments(patientProvider.patient.tei ?? "");
      await scheduleProvider
          .getListHistoryEnrollments(patientProvider.patient.tei ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
        builder: (context, scheduleProvider, child) {
      if (scheduleProvider.requestState == RequestState.Loading) {
        return const Loading();
      }

      return RefreshIndicator(
        onRefresh: () async {
          segmentedControlValue = true;
          await _getEnrollmentOrHistory();
        },
        child: Column(
          children: [
            buildSegment(),
            context.sbHeight(size: 20),
            segmentedControlValue
                ? buildOrder(scheduleProvider)
                : buildOrderHistory(scheduleProvider)
          ],
        ),
      );
    });
  }

  Widget buildOrder(ScheduleProvider scheduleProvider) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: (scheduleProvider.enrollment.events?.isEmpty ?? false)
            ? buildEmpty("Anda belum memiliki\npesanan apapun")
            : Column(
                children: scheduleProvider.enrollment.events?.map(
                      (e) {
                        return Container(
                          width: double.infinity,
                          margin: paddingOnly(
                            left: SizeConstants.margin,
                            right: SizeConstants.margin,
                            bottom: 5.0,
                          ),
                          padding: paddingAll(12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0XFFE4ECF7)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: e.dataValues != null &&
                                  (e.dataValues?.isNotEmpty ?? false)
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          e.getElementValue(e.serviceName),
                                          style: AppTheme.subtitle.copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Visibility(
                                          visible: e.getElementValue(
                                                  e.statusPayment) !=
                                              "2",
                                          child: InkWell(
                                            onTap: () {
                                              SnackBarCustom.showSnackBarMessage(
                                                  context: context,
                                                  title: "Opps !",
                                                  message:
                                                      "Masih dalam Tahap develop",
                                                  typeMessage:
                                                      SnackBarType.error);
                                            },
                                            child: Text(
                                              "Detail",
                                              style: AppTheme.bodyText.copyWith(
                                                fontSize: 14,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Divider(
                                        thickness: 1, color: Color(0XFFE4ECF7)),
                                    ListTile(
                                      minLeadingWidth: 0,
                                      horizontalTitleGap: 5,
                                      isThreeLine: true,
                                      contentPadding: paddingAll(0.0),
                                      leading: const Icon(
                                        FeatherIcons.clock,
                                        color: AppColors.primaryColorDarkColor,
                                      ),
                                      title: Text(
                                        "Jadwal temu",
                                        style: AppTheme.bodyText.copyWith(
                                            color:
                                                AppColors.primaryColorDarkColor,
                                            fontSize: 12),
                                      ),
                                      subtitle: Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat('EEEE ,dd MMMM yyyy',
                                                      "id")
                                                  .format(DateTime.parse(
                                                      e.getElementValue(
                                                          e.serviceDate))),
                                              style: AppTheme.bodyText.copyWith(
                                                fontSize: 12,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${e.getElementValue(e.serviceTime)} Wib",
                                              style: AppTheme.bodyText.copyWith(
                                                fontSize: 12,
                                                color: AppColors
                                                    .primaryColorDarkColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: DottedBorder(
                                        color: getColorServiceType(e),
                                        borderType: BorderType.RRect,
                                        strokeWidth: 1,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        radius: const Radius.circular(6),
                                        child: Text(
                                          e.getElementValue(e.serviceType),
                                          style: AppTheme.bodyText.copyWith(
                                            fontSize: 10,
                                            color: getColorServiceType(e),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(0, -10),
                                      child: ListTile(
                                        minLeadingWidth: 0,
                                        horizontalTitleGap: 5,
                                        contentPadding: paddingAll(0.0),
                                        leading: const Icon(
                                          FeatherIcons.user,
                                          color:
                                              AppColors.primaryColorDarkColor,
                                        ),
                                        title: Text(
                                          e.getElementValue(e.doctor),
                                          style: AppTheme.bodyText.copyWith(
                                            fontSize: 12,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "Dokter Umum",
                                          style: AppTheme.bodyText.copyWith(
                                              color: AppColors
                                                  .primaryColorDarkColor,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),

                                    // CHECK IS HOMECARE
                                    Transform.translate(
                                      offset: const Offset(0, -15),
                                      child: Visibility(
                                        visible:
                                            e.getElementValue(e.serviceType) ==
                                                AppConst.HOME_SERVICE,
                                        child: ListTile(
                                          minLeadingWidth: 0,
                                          horizontalTitleGap: 5,
                                          contentPadding: paddingAll(0.0),
                                          leading: e.getElementValue(
                                                      e.statusPayment) ==
                                                  "0"
                                              ? const Icon(
                                                  FeatherIcons.bell,
                                                  color:
                                                      AppColors.redPrimaryColor,
                                                  size: 20,
                                                )
                                              : AppConst.ICON_PAYMENT_STATUS[
                                                      e.getElementValue(
                                                          e.statusPayment)] ??
                                                  const Icon(
                                                      FeatherIcons.loader,
                                                      color: Color(0xffFF9900)),
                                          title: RichText(
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: e.getElementValue(e
                                                              .statusPayment) ==
                                                          "0"
                                                      ? "Selesaikan proses pembayaran sebelum\n${DateFormat('EEEE ,dd MMMM yyyy hh:mm:dd', "id").format(DateTime.parse(e.getElementValue(e.expiredDate)))}"
                                                      : AppConst.STATUS_PAYMENT[
                                                              e.getElementValue(e
                                                                  .statusPayment)] ??
                                                          e.getElementValue(
                                                              e.statusPayment),
                                                  style: AppTheme.bodyText
                                                      .copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: e.getElementValue(e
                                                                .statusPayment) ==
                                                            "0"
                                                        ? AppColors
                                                            .redPrimaryColor
                                                        : AppConst.COLOR_PAYMENT_STATUS[
                                                                e.getElementValue(e
                                                                    .statusPayment)] ??
                                                            const Color(
                                                                0xffFF9900),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // END CHECK

                                    Transform.translate(
                                      offset: const Offset(0, -15),
                                      child: Visibility(
                                        visible:
                                            e.getElementValue(e.serviceType) !=
                                                AppConst.CLINIC_SERVICE,
                                        child: const Divider(thickness: 1),
                                      ),
                                    ),

                                    Visibility(
                                      visible:
                                          e.getElementValue(e.statusPayment) ==
                                              "2",
                                      child: Transform.translate(
                                        offset: const Offset(0, -5),
                                        child: Buttons(
                                          title: "Detail",
                                          marginBottom: 0,
                                          onTap: () {
                                            SnackBarCustom.showSnackBarMessage(
                                                context: context,
                                                title: "Opps !",
                                                message:
                                                    "Masih dalam Tahap develop",
                                                typeMessage:
                                                    SnackBarType.error);
                                            /*   if (e.getElementValue(
                                                    e.serviceType) !=
                                                clinicService) {
                                              Get.to(
                                                const SummaryScreen(),
                                              );
                                            } else {
                                              Get.to(
                                                const PaymentDetail(),
                                              );
                                            }*/
                                          },
                                        ),
                                      ),
                                    ),

                                    Visibility(
                                      visible: e.getElementValue(
                                                  e.serviceType) ==
                                              AppConst.HOME_SERVICE &&
                                          e.getElementValue(e.statusPayment) !=
                                              "2",
                                      child: Transform.translate(
                                        offset: const Offset(0, -5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                height: 40,
                                                width: 180,
                                                child: ButtonCustom(
                                                  title: "Batalkan Pesanan",
                                                  backgroundColor:
                                                      AppColors.grey200Color,
                                                  titleStyle: AppTheme.bodyText
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontSize: 14),
                                                  marginBottom: 0,
                                                  onTap: () {
                                                    SnackBarCustom
                                                        .showSnackBarMessage(
                                                            context: context,
                                                            title: "Opps !",
                                                            message:
                                                                "Masih dalam Tahap develop",
                                                            typeMessage:
                                                                SnackBarType
                                                                    .error);
                                                    // Navigator.pushNamed(
                                                    //     context, PaymentSuccess.routeName,arguments: [e.bookingId]);
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                height: 40,
                                                width: 137,
                                                child: Buttons(
                                                  title: "Bayar Sekarang",
                                                  marginBottom: 0,
                                                  disabled: e.getElementValue(
                                                          e.statusPayment) !=
                                                      "0",
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        WebViewPage.routeName,
                                                        arguments: [
                                                          // INDEX 0
                                                          e.getElementValue(
                                                            e.paymentUrl,
                                                          ),
                                                          // INDEX 1
                                                          e.getElementValue(
                                                              e.pgCode),
                                                        ]);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : const SizedBox(),
                        );
                      },
                    ).toList() ??
                    <Widget>[],
              ),
      ),
    );
  }

  Widget buildOrderHistory(ScheduleProvider scheduleProvider) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: (scheduleProvider.enrollmentHistory.events?.isEmpty ?? false)
            ? buildEmpty("Anda belum memiliki\nriwayat pesanan apapun")
            : Column(
                children: scheduleProvider.enrollmentHistory.events?.map(
                      (e) {
                        return Container(
                          width: double.infinity,
                          margin: paddingOnly(
                            left: SizeConstants.margin,
                            right: SizeConstants.margin,
                            bottom: 5.0,
                          ),
                          padding: paddingAll(12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0XFFE4ECF7)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: e.dataValues != null &&
                                  (e.dataValues?.isNotEmpty ?? false)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          e.getElementValue(e.serviceName),
                                          style: AppTheme.subtitle.copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                        thickness: 1, color: Color(0XFFE4ECF7)),
                                    ListTile(
                                      minLeadingWidth: 0,
                                      horizontalTitleGap: 5,
                                      isThreeLine: true,
                                      contentPadding: paddingAll(0.0),
                                      leading: const Icon(
                                        FeatherIcons.clock,
                                        color: AppColors.primaryColorDarkColor,
                                      ),
                                      title: Text(
                                        "Jadwal temu",
                                        style: AppTheme.bodyText.copyWith(
                                            color:
                                                AppColors.primaryColorDarkColor,
                                            fontSize: 12),
                                      ),
                                      subtitle: Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat('EEEE ,dd MMMM yyyy',
                                                      "id")
                                                  .format(DateTime.parse(
                                                      e.getElementValue(
                                                          e.serviceDate))),
                                              style: AppTheme.bodyText.copyWith(
                                                fontSize: 12,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${e.getElementValue(e.serviceTime)} Wib",
                                              style: AppTheme.bodyText.copyWith(
                                                fontSize: 12,
                                                color: AppColors
                                                    .primaryColorDarkColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: DottedBorder(
                                        color: getColorServiceType(e),
                                        borderType: BorderType.RRect,
                                        strokeWidth: 1,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        radius: const Radius.circular(6),
                                        child: Text(
                                          e.getElementValue(e.serviceType),
                                          style: AppTheme.bodyText.copyWith(
                                            fontSize: 10,
                                            color: getColorServiceType(e),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      minLeadingWidth: 0,
                                      horizontalTitleGap: 5,
                                      isThreeLine: true,
                                      contentPadding: paddingAll(0.0),
                                      leading: const Icon(
                                        FeatherIcons.user,
                                        color: AppColors.primaryColorDarkColor,
                                      ),
                                      title: Text(
                                        e.getElementValue(e.doctor),
                                        style: AppTheme.bodyText.copyWith(
                                          fontSize: 12,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Dokter Umum",
                                        style: AppTheme.bodyText.copyWith(
                                            color:
                                                AppColors.primaryColorDarkColor,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(65),
                                          color: (AppConst.COLOR_PAYMENT_STATUS[
                                                      e.getElementValue(
                                                          e.statusPayment)] ??
                                                  const Color(0xffFF9900))
                                              .withOpacity(0.1)),
                                      child: Text(
                                        AppConst.STATUS_PAYMENT[
                                                e.getElementValue(
                                                    e.statusPayment)] ??
                                            e.getElementValue(e.statusPayment),
                                        textAlign: TextAlign.center,
                                        style: AppTheme.bodyText.copyWith(
                                            color:
                                                AppConst.COLOR_PAYMENT_STATUS[
                                                        e.getElementValue(
                                                            e.statusPayment)] ??
                                                    const Color(0xffFF9900),
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        );
                      },
                    ).toList() ??
                    <Widget>[],
              ),
      ),
    );
  }

  Widget buildSegment() {
    return Container(
      margin: const EdgeInsets.only(
          top: 23, left: SizeConstants.margin, right: SizeConstants.margin),
      child: CustomSlidingSegmentedControl<bool>(
        height: 40,
        isStretch: true,
        innerPadding: const EdgeInsets.all(4),
        children: {
          true: Text(
            'Janji Temu',
            style: AppTheme.subtitle.copyWith(
              color: segmentedControlValue
                  ? AppColors.whiteColor
                  : AppColors.primaryColor,
            ),
          ),
          false: Text(
            'Riwayat',
            style: AppTheme.subtitle.copyWith(
              color: !segmentedControlValue
                  ? AppColors.whiteColor
                  : AppColors.primaryColor,
            ),
          ),
        },
        onValueChanged: (bool val) {
          setState(() {
            segmentedControlValue = val;
          });
        },
        decoration: BoxDecoration(
          color: const Color(0xffEFEFEF),
          borderRadius: BorderRadius.circular(22),
        ),
        thumbDecoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }

  Widget buildEmpty(String message) {
    return Padding(
      padding: paddingTop(200.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "${Assets.othersPath}/empty_history.png",
              height: 77,
              width: 196,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTheme.bodyText.copyWith(
                color: AppColors.primaryColorDarkColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getColorServiceType(EventEntities e) {
    return Color(e.getElementValue(e.serviceType) == "Kunjungan Klinik"
        ? 0XFF7952B3
        : 0XFFF1774A);
  }
}
