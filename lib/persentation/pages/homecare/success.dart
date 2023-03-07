import 'package:flutter/material.dart';

import '../../../common/resources/assets.dart';
import '../../../common/theme/theme.dart';
import 'components/base_payment.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {

  _done() {
    // _bookingViewModel.clear();
    // Get.offAll(() => const BaseScreen());
    // final isOpenFeedback = GetStorage().read("OPEN_FEEDBACK");
    // if (isOpenFeedback ?? true) {
    //   Alerts.showAlertDialogFeedback(context);
    //   GetStorage().write("OPEN_FEEDBACK", false);
    // }
  }

  _checkPaymentSuccess() {
    // _payementViewModel
    //     .checkPaymentStatus(bookingId: _bookingViewModel.reference.value)
    //     .then((value) {
    //   if (_payementViewModel.paymentStaus.value != "") {
    //     SnackBarMessage.showSnackBarMessage(
    //         title: "Status Pesananmu",
    //         message: statusPayment[_payementViewModel.paymentStaus.value] ??
    //             _payementViewModel.paymentStaus.value,
    //         typeMessage: messageTypePaymentStatus[
    //                 _payementViewModel.paymentStaus.value] ??
    //             SnackBarMessage.error);
    //   }
    // });
  }

  _checkPaymentStatus() {
    final List<dynamic> args =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;

    // _payementViewModel.checkPaymentStatus(bookingId: args[0]).then((value) {
    //   if (_payementViewModel.paymentStaus.value != "") {
    //     SnackBarMessage.showSnackBarMessage(
    //         title: "Status Pesananmu",
    //         message: statusPayment[_payementViewModel.paymentStaus.value] ??
    //             _payementViewModel.paymentStaus.value,
    //         typeMessage: messageTypePaymentStatus[
    //                 _payementViewModel.paymentStaus.value] ??
    //             SnackBarMessage.error);
    //   }
    // });
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (_bookingViewModel.reference.value != "") {
    //     printDebug("_checkPaymentSuccess()");
    //     _checkPaymentSuccess();
    //   } else {
    //     printDebug("_checkPaymentStatus()");
    //     _checkPaymentStatus();
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return BasePaymentScreen(
        btnTitle: "Kembali Ke menu utama",
        enableBackButton: false,
        loading: false,
        onNext: _done,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 210),
            Image.asset(
              "${Assets.logoPath}/logo.png",
              width: 99,
              height: 33,
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              "${Assets.othersPath}/payment.png",
              width: 195,
              height: 148,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Pembayaran anda berhasil",
              style: AppTheme.bodyText.copyWith(
                  color: const Color(0XFF4AAE8C),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      );
  }
}
