import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jd_mobile/common/extensions/context_ext.dart';
import 'package:jd_mobile/common/extensions/entities_ext.dart';
import 'package:jd_mobile/common/helpers/date_helper.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/domain/entities/booking/booking_enitities.dart';
import 'package:jd_mobile/domain/entities/patient/event_entities.dart';
import 'package:jd_mobile/persentation/pages/webview/webview_page.dart';
import 'package:jd_mobile/persentation/provider/order/order_provider.dart';
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
import '../../../domain/entities/patient/patient_entities.dart';
import '../../widgets/buttons.dart';
import '../homecare/payment_detail.dart';
import '../order/summary_page.dart';
import 'components/item_tile.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  bool segmentedControlValue = true;
  late OrderProvider orderProvider;

  @override
  void initState() {
    _getEnrollmentOrHistory();
    initializeDateFormatting();
    super.initState();
  }

  _getEnrollmentOrHistory() {
    Future.delayed(const Duration(seconds: 0), () async {
      orderProvider = Provider.of<OrderProvider>(context, listen: false);
      PatientProvider patientProvider =
          Provider.of<PatientProvider>(context, listen: false);
      ScheduleProvider scheduleProvider =
          Provider.of<ScheduleProvider>(context, listen: false);
      await scheduleProvider
          .getListEnrollments(patientProvider.patient.tei ?? "");
      // await scheduleProvider
      //     .getListHistoryEnrollments(patientProvider.patient.tei ?? "");
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
                            bottom: 10.0,
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
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 15, bottom: 10),
                                      child: Row(
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
                                                getDetailEnrollment(
                                                    e, scheduleProvider);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                child: Text(
                                                  "Detail",
                                                  style: AppTheme.bodyText
                                                      .copyWith(
                                                    fontSize: 14,
                                                    color:
                                                        const Color(0XFF3754DB),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                        thickness: 1, color: Color(0XFFE4ECF7)),
                                    ItemTile(
                                      leading: const Icon(
                                        FeatherIcons.clock,
                                        size: 18,
                                        color: AppColors.primaryColorDarkColor,
                                      ),
                                      title: Text(
                                        "Jadwal temu",
                                        style: AppTheme.bodyText.copyWith(
                                            color:
                                                AppColors.primaryColorDarkColor,
                                            fontSize: 12),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat(
                                                    'EEEE, dd MMMM yyyy', "id")
                                                .format(DateTime.parse(
                                                    e.getElementValue(
                                                        e.serviceDate))),
                                            style: AppTheme.bodyText.copyWith(
                                              fontSize: 12,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${e.getElementValue(e.serviceTime)} ${DateHelper.getTimezon()}",
                                            style: AppTheme.bodyText.copyWith(
                                              fontSize: 12,
                                              color: AppColors
                                                  .primaryColorDarkColor,
                                            ),
                                          )
                                        ],
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
                                      child: ItemTile(
                                        leading: Icon(
                                          e.getElementValue(e.serviceType) ==
                                                  AppConst.HOME_SERVICE
                                              ? FeatherIcons.user
                                              : FeatherIcons.mapPin,
                                          size: 18,
                                          color:
                                              AppColors.primaryColorDarkColor,
                                        ),
                                        title: Text(
                                          e.getElementValue(e.serviceType) ==
                                                  AppConst.HOME_SERVICE
                                              ? e.getElementValue(e.doctor)
                                              : "Alamat Klinik",
                                          style: AppTheme.bodyText.copyWith(
                                            fontSize: 12,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        subtitle: Text(
                                          e.getElementValue(e.serviceType) ==
                                                  AppConst.HOME_SERVICE
                                              ? "Dokter Umum"
                                              : e.getElementValue(e.clinicArea),
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
                                        child: ItemTile(
                                          leading: e.getElementValue(
                                                      e.statusPayment) ==
                                                  "0"
                                              ? const Icon(
                                                  FeatherIcons.bell,
                                                  color:
                                                      AppColors.redPrimaryColor,
                                                  size: 18,
                                                )
                                              : AppConst.ICON_PAYMENT_STATUS[
                                                      e.getElementValue(
                                                          e.statusPayment)] ??
                                                  const Icon(
                                                      FeatherIcons.loader,
                                                      size: 18,
                                                      color: Color(0xffFF9900)),
                                          title: RichText(
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: e.getElementValue(e
                                                              .statusPayment) ==
                                                          "0"
                                                      ? "Selesaikan proses pembayaran sebelum\n${DateFormat('EEEE, dd MMMM yyyy hh:mm:dd', "id").format(DateTime.parse(e.getElementValue(e.expiredDate)))}"
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
                                          e.getElementValue(e.serviceType) ==
                                              AppConst.CLINIC_SERVICE,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(65),
                                            color: const Color(0xffFFEDE3)
                                                .withOpacity(0.4)),
                                        child: Text(
                                          "Silahkan datang ke klinik 20 menit sebelum pemeriksaan",
                                          textAlign: TextAlign.center,
                                          style: AppTheme.bodyText.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xffF1774A),
                                              fontSize: 11),
                                        ),
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
                                            getDetailEnrollment(
                                                e, scheduleProvider);
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
                            bottom: 10.0,
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
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 15, bottom: 10),
                                      child: Row(
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
                                    ),
                                    const Divider(
                                        thickness: 1, color: Color(0XFFE4ECF7)),
                                    ItemTile(
                                      leading: const Icon(
                                        FeatherIcons.clock,
                                        size: 18,
                                        color: AppColors.primaryColorDarkColor,
                                      ),
                                      title: Text(
                                        "Jadwal temu",
                                        style: AppTheme.bodyText.copyWith(
                                            color:
                                                AppColors.primaryColorDarkColor,
                                            fontSize: 12),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat(
                                                    'EEEE, dd MMMM yyyy', "id")
                                                .format(DateTime.parse(
                                                    e.getElementValue(
                                                        e.serviceDate))),
                                            style: AppTheme.bodyText.copyWith(
                                              fontSize: 12,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${e.getElementValue(e.serviceTime)} ${DateHelper.getTimezon()}",
                                            style: AppTheme.bodyText.copyWith(
                                              fontSize: 12,
                                              color: AppColors
                                                  .primaryColorDarkColor,
                                            ),
                                          )
                                        ],
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
                                    ItemTile(
                                      margin: const EdgeInsets.only(top: 10),
                                      leading: Icon(
                                        e.getElementValue(e.serviceType) ==
                                                AppConst.HOME_SERVICE
                                            ? FeatherIcons.user
                                            : FeatherIcons.mapPin,
                                        size: 18,
                                        color: AppColors.primaryColorDarkColor,
                                      ),
                                      title: Text(
                                        e.getElementValue(e.serviceType) ==
                                                AppConst.HOME_SERVICE
                                            ? e.getElementValue(e.doctor)
                                            : "Alamat Klinik",
                                        style: AppTheme.bodyText.copyWith(
                                          fontSize: 12,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        e.getElementValue(e.serviceType) ==
                                                AppConst.HOME_SERVICE
                                            ? "Dokter Umum"
                                            : e.getElementValue(e.clinicArea),
                                        style: AppTheme.bodyText.copyWith(
                                            color:
                                                AppColors.primaryColorDarkColor,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(top: 15),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(65),
                                          color: e.getElementValue(
                                                      e.statusPayment) ==
                                                  "2"
                                              ? const Color(0XFFDEFFEE)
                                              : const Color(0xFFFFE6E4)),
                                      child: Text(
                                        e.getElementValue(e.statusPayment) ==
                                                "2"
                                            ? "Selesai"
                                            : "Dibatalkan",
                                        textAlign: TextAlign.center,
                                        style: AppTheme.bodyText.copyWith(
                                            color: e.getElementValue(
                                                        e.statusPayment) ==
                                                    "2"
                                                ? const Color(0XFF4AAE8C)
                                                : const Color(0xFFEF0C11),
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

  void getDetailEnrollment(
      EventEntities e, ScheduleProvider scheduleProvider) async {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (context) => Center(
        child: Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Loading(),
          ),
        ),
      ),
    );
    await scheduleProvider.getEnrollmentDetail(e.bookingId ?? "").then((value) {
      Navigator.of(context).pop();
      if (scheduleProvider.detailEnrollment.events != null &&
          scheduleProvider.detailEnrollment.events!.isNotEmpty) {
        EventEntities eventEntities =
            scheduleProvider.detailEnrollment.events!.first;
        BookingEntities bookingEntities = orderProvider.bookingEntities;
        PatientEntities patientEntities = orderProvider.patientEntities;
        patientEntities.name =
            eventEntities.getElementValue(eventEntities.namePatient);
        patientEntities.nik =
            eventEntities.getElementValue(eventEntities.nikPatient);
        patientEntities.address =
            eventEntities.getElementValue(eventEntities.clinicArea);
        bookingEntities.doctorName =
            eventEntities.getElementValue(eventEntities.doctor);
        bookingEntities.complaint =
            eventEntities.getElementValue(eventEntities.assesment);
        bookingEntities.serviceType =
            eventEntities.getElementValue(eventEntities.serviceType);
        bookingEntities.service =
            eventEntities.getElementValue(eventEntities.serviceName);
        bookingEntities.visitDate =
            eventEntities.getElementValue(eventEntities.serviceDate);
        bookingEntities.visitTime =
            eventEntities.getElementValue(eventEntities.serviceTime);
        bookingEntities.price =
            eventEntities.getElementValue(eventEntities.totalPay);
        bookingEntities.clinicAddress =
            eventEntities.getElementValue(eventEntities.clinicArea);
        if (e.getElementValue(e.serviceType) == AppConst.CLINIC_SERVICE) {
          Navigator.pushNamed(context, SummaryPage.routeName, arguments: true);
        } else {
          Navigator.pushNamed(context, PaymentDetailPage.routeName,
              arguments: true);
        }
      }
    });
  }
}
