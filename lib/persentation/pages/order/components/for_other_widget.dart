import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/persentation/pages/order/components/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../common/resources/assets.dart';
import '../../../../common/resources/colors.dart';
import '../../../../common/theme/theme.dart';
import '../../../provider/order/order_provider.dart';
import '../../../widgets/button_item_selected.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/universal_empty_state.dart';
import 'bottom_sheet.dart';

class ForOtherWidget extends StatefulWidget {
  final OrderProvider orderProvider;
  final int? patientType;
  final Function onNewPatient;
  final Function onExistingPatient;
  final Function(String) onSearch;

  const ForOtherWidget({
    Key? key,
    required this.patientType,
    required this.orderProvider,
    required this.onExistingPatient,
    required this.onNewPatient,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<ForOtherWidget> createState() => _ForOtherState();
}

class _ForOtherState extends State<ForOtherWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pasien",
          style: AppTheme.subtitle.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w300,
            color: AppColors.darkGreyColor,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            buttonItemSelected(
              title: "Baru",
              isSelected: widget.patientType == 0,
              onTap: widget.onNewPatient,
            ),
            const SizedBox(width: 18),
            buttonItemSelected(
              title: "Sudah terdaftar",
              isSelected: widget.patientType == 1,
              onTap: widget.onExistingPatient,
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (widget.patientType == 0)
          Consumer<OrderProvider>(builder: (context, orderProvider, child) {
            return Visibility(
              visible: orderProvider.requestCreateNewPatientState ==
                  RequestState.Loaded && orderProvider.patientEntities.nik != null,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.grey200Color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      orderProvider.patientEntities.nik ?? "-",
                      style: AppTheme.bodyText.copyWith(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            FeatherIcons.checkCircle,
                            color: AppColors.greenSuccessColor,
                            size: 12,
                          ),
                        ),
                        const WidgetSpan(
                          child: SizedBox(
                            width: 5,
                          ),
                        ),
                        TextSpan(
                          text: " NIK Pasien Baru",
                          style: AppTheme.subtitle.copyWith(
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greenSuccessColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        if (widget.patientType == 1)
          Consumer<OrderProvider>(builder: (context, orderProvider, child) {
            return searchButton(
                label: "Pilih pasien",
                value: orderProvider.patientEntities.name,
                onTap: () {
                  orderProvider.setRequestLoadPatientState(RequestState.Empty);
                  bottomSheetWidget(
                      single: true,
                      context: context,
                      onSearch: widget.onSearch,
                      inputType: TextInputType.number,
                      isInputNIK: true,
                      child: Consumer<OrderProvider>(
                          builder: (context, orderProvider, child) {
                        return orderProvider.requestLoadPatientState ==
                                RequestState.Loading
                            ? const Loading()
                            : orderProvider.requestLoadPatientState ==
                                        RequestState.Loaded &&
                                    orderProvider.patientEntitiesByNIK.name == null
                                ? universalEmptyState()
                                : Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        orderProvider.updatePatient(
                                            orderProvider.patientEntitiesByNIK);
                                        orderProvider.clearPatientByNIK();
                                        Navigator.of(context).pop();
                                      },
                                      child: ListTile(
                                        leading: orderProvider
                                                    .patientEntitiesByNIK.name !=
                                                null
                                            ? Image.asset(
                                                '${Assets.logoPath}/launcher.png')
                                            : const SizedBox.shrink(),
                                        title: Text(
                                          orderProvider.patientEntitiesByNIK.name ??
                                              "",
                                          style: AppTheme.heading6.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        subtitle: Text(
                                          orderProvider.patientEntitiesByNIK.name ??
                                              "",
                                          style: AppTheme.bodyText.copyWith(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                      }));
                });
          }),
      ],
    );
  }
}
