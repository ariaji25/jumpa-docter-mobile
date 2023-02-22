import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/widgets/app_bars.dart';
import 'package:jd_mobile/persentation/widgets/buttons.dart';
import 'package:jd_mobile/persentation/widgets/logo_widget.dart';

class BaseOrderScreen extends StatelessWidget {
  final String title;
  final String subTitle;
  final String btnTitle;
  final Widget child;
  final Function() onNext;
  final Function()? onBack;
  final bool loading;
  final bool enableBackButton;
  final bool disabled;

  const BaseOrderScreen({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.child,
    required this.onNext,
    required this.btnTitle,
    this.onBack,
    this.loading = false,
    this.enableBackButton = true,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppsBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (!enableBackButton)
                  ? const SizedBox(width: 16.0)
                  : IconButton(
                      onPressed: () {
                        if (onBack != null) {
                          onBack!();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
              LogoWidget.logoIcon(height: 23, width: 65, color: Colors.white),
            ],
          ),
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
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: SizeConstants.margin,
              ),
              height: MediaQuery.of(context).size.height * .85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (!subTitle.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text(
                            title,
                            style: AppTheme.heading6.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColorDarkColor,
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              title,
                              style: AppTheme.heading6.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColorDarkColor,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              subTitle,
                              style: AppTheme.heading5.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryColorDarkColor,
                              ),
                            )
                          ],
                        ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: child,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Buttons(
                    title: btnTitle,
                    onTap: onNext,
                    disabled: disabled,
                    loading: loading,
                    borderRadius: 6,
                    marginBottom: 10,
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
