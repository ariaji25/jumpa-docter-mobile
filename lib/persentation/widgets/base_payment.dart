import 'package:flutter/material.dart';
import 'package:jd_mobile/persentation/widgets/logo_widget.dart';

import '../../common/resources/colors.dart';
import '../../common/resources/size.dart';
import '../../common/theme/theme.dart';
import 'app_bars.dart';
import 'buttons.dart';

class BasePaymentPage extends StatelessWidget {
  final String btnTitle;
  final Widget child;
  final Function() onNext;
  final Function()? onBack;
  final bool loading;
  final bool enableBackButton;
  final bool disabled;
  final String? price;
  final bool isPayment;
  final bool withSingleChildScrollView;
  final Widget totalWidget;

  const BasePaymentPage(
      {Key? key,
      required this.child,
      required this.onNext,
      required this.btnTitle,
      this.onBack,
      this.loading = false,
      this.enableBackButton = true,
      this.disabled = false,
      this.price,
      this.isPayment = false,
      this.withSingleChildScrollView = true,
      this.totalWidget = const SizedBox()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppsBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (!enableBackButton)
                  ? const SizedBox(width: 16.0)
                  : IconButton(
                      onPressed: () {
                        if (onBack != null) {
                          onBack!();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: AppColors.primaryColor, height: 1.0),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: LogoWidget.logoWhite,
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              // color: Colors.red,
              // padding: const EdgeInsets.symmetric(horizontal: margin),
              height: MediaQuery.of(context).size.height * .90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: withSingleChildScrollView
                        ? SingleChildScrollView(
                            child: child,
                          )
                        : child,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SizeConstants.margin,
                      vertical: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 15,
                          offset: Offset(
                            0.0,
                            10.0,
                          ),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        totalWidget,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isPayment
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 68.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total bayar",
                                          style: AppTheme.subtitle.copyWith(
                                              fontSize: 12,
                                              color: AppColors
                                                  .primaryColorDarkColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          price ?? "",
                                          style: AppTheme.subtitle.copyWith(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            Expanded(
                              child: Buttons(
                                title: btnTitle,
                                onTap: onNext,
                                disabled: disabled,
                                loading: loading,
                              ),
                            ),
                          ],
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
}
