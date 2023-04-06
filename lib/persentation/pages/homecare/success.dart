import 'package:flutter/material.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/resources/snackbar.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/persentation/pages/base/base_page.dart';
import 'package:jd_mobile/persentation/provider/order/order_provider.dart';
import 'package:jd_mobile/persentation/provider/payment/payment_provider.dart';
import 'package:jd_mobile/persentation/widgets/loading.dart';
import 'package:provider/provider.dart';

import '../../../common/resources/assets.dart';
import '../../../common/theme/theme.dart';
import 'components/base_payment.dart';

class PaymentSuccess extends StatefulWidget {
  static const routeName = "/PaymentSuccess";
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  late OrderProvider orderProvider;
  late PaymentProvider paymentProvider;

  @override
  void initState() {
    super.initState();
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // if (_bookingViewModel.reference.value != "") {
      //   printDebug("_checkPaymentSuccess()");
      //   _checkPaymentSuccess();
      // } else {
      //   printDebug("_checkPaymentStatus()");
      _checkPaymentSuccess();
      // }
    });
  }

  _done() {
    orderProvider.clear();
    Navigator.pushNamedAndRemoveUntil(
      context,
      BasePage.routeName,
      (route) => false,
    );
    // final isOpenFeedback = GetStorage().read("OPEN_FEEDBACK");
    // if (isOpenFeedback ?? true) {
    //   Alerts.showAlertDialogFeedback(context);
    //   GetStorage().write("OPEN_FEEDBACK", false);
    // }
  }

  _checkPaymentSuccess() {
    paymentProvider
        .checkPaymentStatus(bookingId: orderProvider.reference)
        .then((value) {
      if (paymentProvider.paymentStatus != "") {
        SnackBarCustom.showSnackBarMessage(
          context: context,
          title: "Status Pesananmu",
          message: AppConst.STATUS_PAYMENT[paymentProvider.paymentStatus],
          typeMessage: SnackBarType.success,
        );
      }
    });
  }

  _checkPaymentStatus() {
    // final List<dynamic> args =
    //     ModalRoute.of(context)?.settings.arguments as List<dynamic>;

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
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, value, _) {
        return BasePaymentScreen(
          btnTitle: "Kembali Ke menu utama",
          enableBackButton: false,
          loading: value.paymentStatusState == RequestState.Loading,
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
              value.paymentStatusState == RequestState.Loading ? 
              const Center(child: Loading()) :
              Text(
                AppConst.STATUS_PAYMENT[paymentProvider.paymentStatus],
                style: AppTheme.bodyText.copyWith(
                  color: const Color(0XFF4AAE8C),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
