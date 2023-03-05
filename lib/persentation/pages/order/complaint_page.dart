import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/domain/entities/services_jd/service_jd_entities.dart';
import 'package:jd_mobile/persentation/pages/order/components/base_screen_order.dart';
import 'package:jd_mobile/persentation/pages/order/components/button_item_selected.dart';
import 'package:jd_mobile/persentation/pages/order/doctor_page.dart';
import 'package:jd_mobile/persentation/provider/order/order_provider.dart';
import 'package:jd_mobile/persentation/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../../widgets/confirm_modal.dart';

class ComplaintPage extends StatefulWidget {
  static const routeName = "/ComplaintPage";

  const ComplaintPage({super.key});

  @override
  State<StatefulWidget> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  late OrderProvider orderProvider;

  final TextEditingController _complaintCtrl = TextEditingController();
  final TextEditingController _nik = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  final TextEditingController _phoneNumberCtrl = TextEditingController();

  int _orderFor = 0;
  int? _patientType;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final formKeyNewPatient = GlobalKey<FormState>();

  @override
  void initState() {
    orderProvider = Provider.of<OrderProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final params = ModalRoute.of(context)?.settings.arguments as JumpaDokterServiceEntities;
    orderProvider.setServiceId(params.serviceId);
    orderProvider.bookingEntities.service = params.title;
    orderProvider.bookingEntities.orderType = "Diri Sendiri";

    return BaseOrderScreen(
      title: params.title == "Swab Antigen" ? "Tujuan SWAB Antigen" : "Detail Keluhan",
      subTitle: params.title == "Swab Antigen" ? "" : "Tambahkan rincian keluhan anda",
      btnTitle: "Lanjut",
      onNext: () {
        if (formkey.currentState!.validate()) {
          Navigator.pushNamed(context, DoctorPage.routeName);
        }
      },
      onBack: _onCancelOrder,
      loading: false,
      disabled: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              color: params.bgColor ?? AppColors.grey200Color,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  params.logoPath,
                  width: 26,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  params.title,
                  style: AppTheme.bodyText.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: params.titleColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Form(
            key: formkey,
            child: textFieldWidgetWithBorder(
              label: params.title == "Swab Antigen"
                  ? "Tujuan Swab Antigen"
                  : "Keluhan yang anda rasakan",
              controller: _complaintCtrl,
              inputType: TextInputType.text,
              maxLines: 8,
              minLines: 8,
              isShowingLable: false,
              onChanged: (value) {
                orderProvider.bookingEntities.complaint = value;
              },
            ),
          ),
          const SizedBox(height: 25),
          Text(
            "Pesan dokter untuk",
            style: AppTheme.subtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.darkGreyColor,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              ButtonItemSelect(
                title: "Diri Sendiri",
                borderRadius: 6,
                isSelected: _orderFor == 0,
                onTap: () {
                  _onSelectedOrderFor(0, "Diri Sendiri");
                },
              ),
              const SizedBox(width: 18),
              ButtonItemSelect(
                title: "Orang Lain",
                borderRadius: 6,
                isSelected: _orderFor == 1,
                onTap: () {
                  _onSelectedOrderFor(1, "Orang Lain");
                },
              ),
            ],
          ),
          const SizedBox(height: 25),
          Visibility(
            visible: _orderFor == 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "No NIK",
                  style: AppTheme.subtitle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkGreyColor,
                  ),
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: orderProvider.checkNikPatient(),
                  builder: (context, value) {
                    return Row(
                      children: [
                        Visibility(
                          visible:
                              orderProvider.requestState == RequestState.Loaded,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.grey200Color,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              orderProvider.nikPatient ?? "-",
                              style: AppTheme.bodyText.copyWith(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        orderProvider.requestState == RequestState.Loading
                            ? const Center(
                                child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ))
                            : orderProvider.nikPatient != null
                                ? RichText(
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
                                          text: " Data NIK ditemukan",
                                          style: AppTheme.subtitle.copyWith(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.greenSuccessColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : RichText(
                                    text: TextSpan(
                                      children: [
                                        const WidgetSpan(
                                          child: Icon(
                                            FeatherIcons.x,
                                            color: Color(0XFFEF0C11),
                                            size: 12,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " Data NIK tidak ditemukan",
                                          style: AppTheme.subtitle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0XFFEF0C11),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _onSelectedOrderFor(int t, String s) {
    //
  }

  void _onSelectedPatientType(int t) {
    //
  }

  void getDetailPatientByNIk() {
    //
  }

  _onCancelOrder() {
    confirmModal(
      context,
      "Batalkan Pesanan",
      "Yakin ingin membatalkan pesanan anda?",
      onOk: () {
        Navigator.of(context).pop();

        orderProvider.clear();
      },
    );
  }

  _onCheckUseWaNumber(checked) {
    //
  }

  _onCreateNewPatient() {
    //
  }

  _createPatient() {
    //
  }

  void messageRequired(String message) {
    //
  }
}
