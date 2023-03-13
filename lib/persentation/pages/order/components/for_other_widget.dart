import 'package:flutter/material.dart';
import 'package:jd_mobile/persentation/pages/order/components/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../common/resources/assets.dart';
import '../../../../common/resources/colors.dart';
import '../../../../common/theme/theme.dart';
import '../../../provider/order/order_provider.dart';
import '../../../widgets/button_item_selected.dart';
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
        if (widget.patientType == 1)
          searchButton(
            label: "Pilih pasien",
            value: widget.orderProvider.patientEntities.name,
            onTap: () {
              bottomSheetWidget(
                single: true,
                context: context,
                onSearch: widget.onSearch,
                inputType: TextInputType.number,
                isInputNIK: true,
                child: Consumer<OrderProvider>(
                  builder: (context, scheduleProvider, child) {
                    return widget.orderProvider.loadPatient
                        ? loadingWidget
                        : Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: ListTile(
                                leading:
                                    widget.orderProvider.patientEntities.name !=
                                            null
                                        ? Image.asset(
                                            '${Assets.logoPath}/launcher.png')
                                        : const SizedBox.shrink(),
                                title: Text(
                                  widget.orderProvider.patientEntities.name ??
                                      "",
                                  style: AppTheme.heading6.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  widget.orderProvider.patientEntities.name ??
                                      "",
                                  style: AppTheme.bodyText.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                ),
              );
            },
          ),
      ],
    );
  }
}
