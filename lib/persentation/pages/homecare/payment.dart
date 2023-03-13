import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/resources/assets.dart';
import '../../../common/resources/colors.dart';
import '../../../common/theme/theme.dart';
import 'components/base_payment.dart';

class PaymentPage extends StatefulWidget {
  static const routeName = "/PaymentPage";
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentState();
}

class _PaymentState extends State<PaymentPage> {
  var _pgCode = "801";

  _init() async {
    // await _paymentViewModel.getPaymentMethod();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePaymentScreen(
      btnTitle: "Bayar",
      child: Consumer(
        builder: (context, value, child) {
          return Text("");
        },
      ),
      // if (_paymentViewModel.isLoading.value == true) {
      //         return Padding(
      //           padding: paddingTop(MediaQuery.of(context).size.height / 2.5),
      //           child: const Center(
      //             child: CircularProgressIndicator(),
      //           ),
      //         );
      //       }

      //       if (_paymentViewModel.isLoading.value == false) {
      //         return Padding(
      //           padding: const EdgeInsets.symmetric(horizontal:SizeConstants.margin),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const SizedBox(height: 30),
      //               Center(
      //                 child: Text(
      //                   "Metode pembayaran",
      //                   style: AppTheme.heading5.copyWith(
      //                       fontSize: 18,
      //                       fontWeight: FontWeight.w700,
      //                       color: AppColors.primaryColorDarkColor),
      //                 ),
      //               ),
      //               const SizedBox(height: 5),
      //               Center(
      //                 child: Text(
      //                   "Pilih metode pembayaran anda dengan mudah",
      //                   style: AppTheme.subtitle.copyWith(
      //                       fontWeight: FontWeight.w400,
      //                       color: AppColors.primaryColorDarkColor,
      //                       fontSize: 12),
      //                 ),
      //               ),
      //               const SizedBox(height: 26),
      //               Text(
      //                 "Virtual account",
      //                 style: AppTheme.subtitle.copyWith(
      //                     fontSize: 14,
      //                     color: AppColors.primaryColorDarkColor,
      //                     fontWeight: FontWeight.w500),
      //               ),
      //               const SizedBox(height: 10),
      //               Column(
      //                 children: _paymentViewModel.paymentModel.value.va!
      //                     .map(
      //                       (e) => PayemntTile(
      //                         isActive: _pgCode == e.pgCode,
      //                         title: e.pgName,
      //                         image: pickIconPayment[e.pgCode]!,
      //                         onTap: () {
      //                           onChnage(e.pgCode);
      //                         },
      //                       ),
      //                     )
      //                     .toList(),
      //               ),
      //               Text(
      //                 "E-Wallet",
      //                 style: AppTheme.subtitle.copyWith(
      //                     fontSize: 14,
      //                     color: AppColors.primaryColorDarkColor,
      //                     fontWeight: FontWeight.w500),
      //               ),
      //               const SizedBox(height: 10),
      //               Column(
      //                 children:
      //                     _paymentViewModel.paymentModel.value.eWallet!.map(
      //                   (e) {
      //                     return PayemntTile(
      //                       isActive: _pgCode == e.pgCode,
      //                       title: e.pgName,
      //                       image: pickIconPayment[e.pgCode]!,
      //                       onTap: () {
      //                         onChnage(e.pgCode);
      //                       },
      //                     );
      //                   },
      //                 ).toList(),
      //               ),
      //               Visibility(
      //                 visible: false,
      //                 child: Container(
      //                     padding: const EdgeInsets.symmetric(
      //                         horizontal: 14, vertical: 8),
      //                     width: double.infinity,
      //                     decoration: BoxDecoration(
      //                       color: const Color(0xffFFEDE3),
      //                       borderRadius: BorderRadius.circular(100),
      //                     ),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         const Icon(
      //                           FeatherIcons.bell,
      //                           color: Color(0XFFF1774A),
      //                           size: 16,
      //                         ),
      //                         const SizedBox(
      //                           width: 5,
      //                         ),
      //                         Text(
      //                           "Selesaikan pembayaran sebelum 18.00 WIB",
      //                           style: kBodyText.copyWith(
      //                               fontSize: 12,
      //                               fontWeight: FontWeight.w400,
      //                               color: const Color(0XFFF1774A)),
      //                         ),
      //                       ],
      //                     )),
      //               ),
      //               buildCardPrice(_bookingViewModel.booking.value.price != ""
      //                   ? formatCurrency(
      //                       _bookingViewModel.booking.value.price ?? "0")
      //                   : "0")
      //             ],
      //           ),
      //         );
      //       }

      //       if (_paymentViewModel.errMsg.value != "") {
      //         return Padding(
      //           padding: paddingTop(MediaQuery.of(context).size.height / 2.5),
      //           child: Center(
      //             child: Text(
      //               _paymentViewModel.errMsg.toString(),
      //               style: AppTheme.subtitle.copyWith(color: Colors.red),
      //             ),
      //           ),
      //         );
      //       }

      //       return const SizedBox();
      onNext: () async {
        // await _paymentViewModel.generatePayment(
        //     model: _bookingViewModel.booking.value,
        //     bookingId: _bookingViewModel.reference.value,
        //     paymentChannel: _pgCode,
        //   );
        //   printDebug(_paymentViewModel.paymentUrlModel.value.paymentUrl);
        //   printDebug(_paymentViewModel.paymentUrlModel.value.trxId);
        //   Get.to(
        //     const WebViewPage(),
        //     arguments: [
        //       _paymentViewModel.paymentUrlModel.value,
        //       _pgCode,
        //     ],
        //   );
      },
      loading: false,
    );
  }

  void onChnage(String val) {
    setState(() {
      _pgCode = val;
    });
  }
}

class PayemntTile extends StatefulWidget {
  final Function onTap;
  final bool isActive;
  final String title;
  final String image;

  const PayemntTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.image,
    this.isActive = false,
  }) : super(key: key);

  @override
  State<PayemntTile> createState() => _PayemntTileState();
}

class _PayemntTileState extends State<PayemntTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.isActive
                ? AppColors.primaryColor
                : const Color(0XFFE4ECF7),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                "${Assets.logoPath}/${widget.image}",
                height: 15,
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              flex: 7,
              child: Text(
                widget.title,
                style: AppTheme.subtitle.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Visibility(
              visible: widget.isActive,
              child: Icon(
                Icons.check_circle_outline_sharp,
                color: widget.isActive ? Colors.green : AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
