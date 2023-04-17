import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/extensions/padding_ext.dart';
import 'package:jd_mobile/common/helpers/date_helper.dart';
import 'package:jd_mobile/common/helpers/helpers.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/persentation/pages/webview/webview_page.dart';
import 'package:jd_mobile/persentation/provider/order/order_provider.dart';
import 'package:jd_mobile/persentation/provider/payment/payment_provider.dart';
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
  late OrderProvider orderProvider;
  late PaymentProvider paymentProvider;

  @override
  void initState() {
    super.initState();
    _init();
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
  }

  _init() async {
    Future.microtask(() {
      return Provider.of<PaymentProvider>(context, listen: false).getPayment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, value, _) {
        return BasePaymentScreen(
          btnTitle: "Bayar",
          onNext: () async {
            await paymentProvider.genratePayment({
              "booking_id": orderProvider.reference,
              "product_id": orderProvider.bookingEntities.service,
              "product_name": orderProvider.bookingEntities.serviceType,
              "product_price": "${orderProvider.bookingEntities.price}00",
              "payment_channel": _pgCode,
              "patient_id": orderProvider.patientEntities.tei,
              "patient_name": orderProvider.patientEntities.name,
              "booking_date":
                  "${orderProvider.bookingEntities.visitDate} ${orderProvider.bookingEntities.visitTime}"
            }).then((value) {
              log('PAYMENT URL -- ${paymentProvider.paymentUrls}');
              Navigator.pushNamed(
                context,
                WebViewPage.routeName,
                arguments: [
                  paymentProvider.paymentUrls,
                  _pgCode,
                ],
              );
            });
          },
          loading: value.genratePaymentState == RequestState.Loading,
          child: Consumer<PaymentProvider>(
            builder: (context, value, child) {
              if (value.stateGetMethod == RequestState.Loading) {
                return Padding(
                  padding: paddingTop(MediaQuery.of(context).size.height / 2.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (value.stateGetMethod == RequestState.Loaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SizeConstants.margin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Center(
                        child: Text(
                          "Metode pembayaran",
                          style: AppTheme.heading5.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColorDarkColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Text(
                          "Pilih metode pembayaran anda dengan mudah",
                          style: AppTheme.bodyText.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColorDarkColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 26),
                      Text(
                        "Virtual account",
                        style: AppTheme.bodyText.copyWith(
                          fontSize: 14,
                          color: AppColors.primaryColorDarkColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: value.paymentEntites!.va!
                            .map(
                              (e) => PayemntTile(
                                isActive: _pgCode == e.pgCode,
                                title: e.pgName ?? "-",
                                image: AppConst.pickIconPayment[e.pgCode]!,
                                onTap: () {
                                  onChnage(e.pgCode ?? "");
                                },
                              ),
                            )
                            .toList(),
                      ),
                      Text(
                        "E-Wallet",
                        style: AppTheme.bodyText.copyWith(
                          fontSize: 14,
                          color: AppColors.primaryColorDarkColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: value.paymentEntites!.eWallet!.map(
                          (e) {
                            return PayemntTile(
                              isActive: _pgCode == e.pgCode,
                              title: e.pgName ?? "-",
                              image: AppConst.pickIconPayment[e.pgCode]!,
                              onTap: () {
                                onChnage(e.pgCode ?? "-");
                              },
                            );
                          },
                        ).toList(),
                      ),
                      Visibility(
                        visible: false,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFEDE3),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FeatherIcons.bell,
                                color: Color(0XFFF1774A),
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Selesaikan pembayaran sebelum 18.00 ${DateHelper.getTimezon()}",
                                style: AppTheme.bodyText.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(
                                    0XFFF1774A,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      buildCardPrice(
                        orderProvider.bookingEntities.price != null &&
                                orderProvider.bookingEntities.price != ""
                            ? Helpers.formatCurrency(
                                orderProvider.bookingEntities.price ?? "0")
                            : "0",
                      )
                    ],
                  ),
                );
              }

              return Padding(
                padding: paddingTop(MediaQuery.of(context).size.height / 2.5),
                child: Center(
                  child: Text(
                    value.errMsg.toString(),
                    style: AppTheme.subtitle.copyWith(color: Colors.red),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void onChnage(String val) {
    setState(() {
      _pgCode = val;
    });
  }

  Widget buildCardPrice(String price) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey200Color,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total yang harus dibayar",
            style: AppTheme.bodyText.copyWith(
                fontSize: 12,
                color: AppColors.primaryColorDarkColor,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            price,
            style: AppTheme.bodyText.copyWith(
              fontSize: 12,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
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
