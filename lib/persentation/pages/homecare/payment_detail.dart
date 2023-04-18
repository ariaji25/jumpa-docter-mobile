// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/helpers/date_helper.dart';
import 'package:jd_mobile/common/helpers/helpers.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/persentation/pages/homecare/payment.dart';
import 'package:provider/provider.dart';

import '../../../common/resources/colors.dart';
import '../../../common/resources/snackbar.dart';
import '../../../common/theme/theme.dart';
import '../../../domain/entities/booking/booking_enitities.dart';
import '../../provider/order/order_provider.dart';
import '../../provider/patient/patient_provider.dart';
import '../base/base_page.dart';
import 'components/base_payment.dart';
import 'components/components.dart';

class PaymentDetailPage extends StatefulWidget {
  static const routeName = '/PaymentDetailPage';
  final bool fromDetail;

  const PaymentDetailPage({Key? key, this.fromDetail = false})
      : super(key: key);

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  late OrderProvider orderProvider;
  late PatientProvider patientProvider;

  @override
  void initState() {
    super.initState();
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    patientProvider = Provider.of<PatientProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, provider, _) {
      return BasePaymentScreen(
        btnTitle: widget.fromDetail ? "Tutup" : "Lanjut",
        isPayment: true,
        price: orderProvider.bookingEntities.price != ""
            ? Helpers.formatCurrency(orderProvider.bookingEntities.price ?? "0")
            : "0",
        onNext: () => widget.fromDetail
            ? Navigator.of(context).pop()
            : makeAppointment(orderProvider),
        loading: orderProvider.makeAppointmentState == RequestState.Loading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Ringkasan pembayaran",
                style: AppTheme.heading5.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColorDarkColor),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Detail keluhan dan biaya",
                style: AppTheme.subtitle.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColorDarkColor,
                    fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: AppColors.grey200Color,
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 25),
            ),
            const SizedBox(height: 25),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
              child: Text(
                "Pembayaran",
                style: AppTheme.subtitle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.primaryColorDarkColor,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
              child: cardTile(
                "Biaya permeriksaan umum",
                orderProvider.bookingEntities.price != ""
                    ? Helpers.formatCurrency(
                        orderProvider.bookingEntities.price ?? "0")
                    : "0",
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 1.5,
              color: AppColors.grey200Color,
              margin:
                  const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
            ),
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
              child: cardTile(
                  "Total bayar",
                  orderProvider.bookingEntities.price != ""
                      ? Helpers.formatCurrency(
                          orderProvider.bookingEntities.price ?? "0")
                      : "0",
                  isBold: true,
                  fontSize: 14),
            ),
            const SizedBox(height: 15),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    FontAwesomeIcons.circleExclamation,
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
            ),
            const SizedBox(height: 30),
            const Divider(color: Color(0xffEDF2F7), thickness: 5),
            const SizedBox(height: 30),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
              child: Text(
                "Dokter yang menangani",
                style: AppTheme.subtitle.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: AppColors.primaryColorDarkColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SizeConstants.margin),
                  child: Text(
                    orderProvider.bookingEntities.doctorName ?? "",
                    style: AppTheme.subtitle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                        fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SizeConstants.margin),
                  child: Text(
                    "Dokter umum",
                    style: AppTheme.subtitle.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.primaryColorDarkColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(color: Color(0xffEDF2F7), thickness: 5),
            const SizedBox(height: 30),
            cardColumn(
              "Nama pasien",
              orderProvider.patientEntities.name ?? "-",
            ),
            cardColumn(
              "Layanan",
              orderProvider.bookingEntities.service ?? "",
            ),
            cardColumn(
              "Keluhan yang dirasakan",
              orderProvider.bookingEntities.complaint ?? "",
            ),
            cardColumn(
              "Waktu tanggal berobat",
              "${orderProvider.bookingEntities.visitTime} ${DateHelper.getTimezon()} - ${DateHelper.dateTimeToLocalDate(orderProvider.bookingEntities.visitDate)!.replaceAll("-", "/")}",
            ),
            cardColumn(
              "Alamat janji temu",
              orderProvider.patientEntities.address ?? "-",
            ),
          ],
        ),
      );
    });
  }

  void makeAppointment(OrderProvider orderProvider) async {
    if (orderProvider.bookingEntities.orderType == AppConst.ORDER_FOR_OTHER) {
      BookingEntities bookingEntities = orderProvider.bookingEntities;
      bookingEntities.teiReference = orderProvider.patientEntities.tei;
      bookingEntities.refNIK = patientProvider.patient.nik;
      bookingEntities.refNama = patientProvider.patient.name;
      bookingEntities.status = "COMPLETED";
      orderProvider.updateBooking(bookingEntities);
      await orderProvider.makeAppointment();

      if (orderProvider.makeAppointmentState != RequestState.Loaded) {
        SnackBarCustom.showSnackBarMessage(
          context: context,
          title: "Hmmm !",
          message: "Maaf ya, Pesananmu belum berhasil dibuat nih!",
          typeMessage: SnackBarType.error,
        );
      }
    }

    if ((orderProvider.makeAppointmentState == RequestState.Loaded &&
            orderProvider.bookingEntities.orderType ==
                AppConst.ORDER_FOR_OTHER) ||
        orderProvider.bookingEntities.orderType != AppConst.ORDER_FOR_OTHER) {
      // Store the booking history in patient
      BookingEntities bookingEntities = orderProvider.bookingEntities;
      bookingEntities.teiReference = patientProvider.patient.tei;
      bookingEntities.refNIK = orderProvider.patientEntities.nik;
      bookingEntities.refNama = orderProvider.patientEntities.name;
      bookingEntities.status = "ACTIVE";
      orderProvider.updateBooking(bookingEntities);
      await orderProvider.makeAppointment();
      if (orderProvider.makeAppointmentState == RequestState.Loaded) {
        SnackBarCustom.showSnackBarMessage(
            context: context,
            title: "Yey !",
            message: "Berhasil memesan layanan.",
            typeMessage: SnackBarType.success);
      } else {
        SnackBarCustom.showSnackBarMessage(
          context: context,
          title: "Hmmm !",
          message: "Maaf ya, Pesananmu belum berhasil dibuat nih!",
          typeMessage: SnackBarType.error,
        );
      }
      Navigator.pushNamed(context, PaymentPage.routeName);
    }
  }
}
