import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/domain/entities/patient/patient_entities.dart';
import 'package:jd_mobile/persentation/provider/order/order_provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/helpers/helpers.dart';
import '../../../../common/resources/assets.dart';
import '../../../../common/resources/colors.dart';
import '../../../../common/theme/theme.dart';
import '../../../../common/utils/state_enum.dart';
import '../../../provider/map/map_provider.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/text_field.dart';
import '../../account/components/map/map_page.dart';
import 'radio_button_gender.dart';

bottomSheetPatientWidget(
    BuildContext context,
    Function(bool?) onCheckUseNumber,
    TextEditingController phoneNumberCtrl,
    TextEditingController dobCtrl,
    Function() onOrderForOther,
    GlobalKey formKey
// CTRL
    ) {
  return showModalBottomSheet(
    enableDrag: true,
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) {
      return Consumer2<MapProvider, OrderProvider>(
          builder: (context, mapProvider, orderProvider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
          height: MediaQuery.of(context).size.height * .80,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 107,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: const Color(0XFF101225),
                      borderRadius: BorderRadius.circular(2.5)),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Lengkapi data diri pasien",
                  style: AppTheme.subtitle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColorDarkColor,
                  ),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        textFieldWidgetWithBorder(
                          label: "Nama Lengkap Pasien",
                          hintText: "Nama Kamu",
                          inputType: TextInputType.text,
                          isName: true,
                          prefixIcon: const Icon(FeatherIcons.user),
                          isUnderline: true,
                          formatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z-" "]'),
                            ),
                          ],
                          onChanged: (value) {
                            PatientEntities patientEntities =
                                orderProvider.newPatientEntities;
                            patientEntities.name = value;
                            orderProvider.updateNewPatient(patientEntities);
                          },
                        ),
                        const SizedBox(height: 12),
                        textFieldWidgetWithBorder(
                          label: "Alamat Domisili",
                          hintText: "Jl. ABC",
                          prefixIcon: const Icon(FeatherIcons.mapPin),
                          isUnderline: true,
                          inputType: TextInputType.text,
                          onChanged: (value) {
                            PatientEntities patientEntities =
                                orderProvider.newPatientEntities;
                            patientEntities.domicilieAddress = value;
                            orderProvider.updateNewPatient(patientEntities);
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        InkWell(
                          onTap: () {
                            String latLang = "";
                            if (mapProvider.selectedPosition.latitude != 0 &&
                                mapProvider.selectedPosition.longitude != 0) {
                              latLang =
                                  '${mapProvider.selectedPosition.latitude},${mapProvider.selectedPosition.longitude}';
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapPage(
                                      latLng: latLang,
                                      onTap: (value) {
                                        if (value.latitude != 0 &&
                                            value.longitude != 0) {
                                          List<double> listLatLong = [
                                            value.longitude,
                                            value.latitude
                                          ];
                                          PatientEntities patientEntities =
                                              orderProvider.newPatientEntities;
                                          patientEntities.coordinate =
                                              jsonEncode(listLatLong);
                                          orderProvider.updateNewPatient(
                                              patientEntities);
                                        }
                                      })),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                                color: const Color(0XFFE1E8FF),
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "${Assets.iconsPath}/map_pin.png",
                                  width: 15,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Pin alamat dengan maps",
                                  style: AppTheme.bodyText.copyWith(
                                      fontSize: 14,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: mapProvider.selectedDetailAddress != "",
                          child: Column(
                            children: [
                              const SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    FeatherIcons.checkCircle,
                                    color: AppColors.greenSuccessColor,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    mapProvider.selectedDetailAddress,
                                    style: AppTheme.bodyText.copyWith(
                                        fontSize: 10,
                                        color: AppColors.primaryColor),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        textFieldWidgetWithBorder(
                          label: "No KTP",
                          hintText: "5201012345678",
                          isNik: true,
                          prefixIcon: const Icon(FeatherIcons.creditCard),
                          isUnderline: true,
                          inputType: TextInputType.number,
                          formatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) {
                            PatientEntities patientEntities =
                                orderProvider.newPatientEntities;
                            patientEntities.nik = value;
                            orderProvider.updateNewPatient(patientEntities);
                          },
                        ),
                        const SizedBox(height: 12),
                        textFieldWidgetWithBorder(
                          label: "Alamat KTP",
                          hintText: "Jl. ABC",
                          prefixIcon: const Icon(FeatherIcons.map),
                          isUnderline: true,
                          inputType: TextInputType.text,
                          onChanged: (value) {
                            PatientEntities patientEntities =
                                orderProvider.newPatientEntities;
                            patientEntities.address = value;
                            orderProvider.updateNewPatient(patientEntities);
                          },
                        ),
                        const SizedBox(height: 12),
                        textFieldWidgetWithBorder(
                          label: "Nomor Whatsapp",
                          inputType: TextInputType.number,
                          hintText: "08123456789",
                          prefixIcon: const Icon(FeatherIcons.phone),
                          isUnderline: true,
                          formatters: [FilteringTextInputFormatter.digitsOnly],
                          isTelephone: true,
                          onChanged: (value) {
                            PatientEntities patientEntities =
                                orderProvider.newPatientEntities;
                            patientEntities.waNumber = value;
                            patientEntities.phoneNumber = value;
                            orderProvider.updateNewPatient(patientEntities);
                          },
                        ),
                        Transform.translate(
                          offset: const Offset(-10, 0),
                          child: ListTileTheme(
                            contentPadding: EdgeInsets.zero,
                            child: CheckboxListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: Text(
                                "Gunakan Nomor Whatsapp? ",
                                style: GoogleFonts.poppins(),
                              ),
                              value: orderProvider.waNumberEqPhoneNumber,
                              onChanged: onCheckUseNumber,
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                        ),
                        if (orderProvider.waNumberEqPhoneNumber == false)
                          textFieldWidgetWithBorder(
                            label: "Nomor Hp",
                            hintText: "08123456789",
                            controller: phoneNumberCtrl,
                            prefixIcon: const Icon(FeatherIcons.phoneCall),
                            isUnderline: true,
                            isOptional: orderProvider.waNumberEqPhoneNumber,
                            inputType: TextInputType.number,
                            formatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            isTelephone: true,
                            onChanged: (value) {
                              PatientEntities patientEntities =
                                  orderProvider.newPatientEntities;
                              patientEntities.phoneNumber = value;
                              orderProvider.updateNewPatient(patientEntities);
                            },
                          ),
                        const SizedBox(height: 12),
                        textFieldWidgetWithBorder(
                          label: "Tempat Lahir",
                          inputType: TextInputType.text,
                          hintText: "Jakarta",
                          prefixIcon: const Icon(FeatherIcons.home),
                          isUnderline: true,
                          onChanged: (value) {
                            PatientEntities patientEntities =
                                orderProvider.newPatientEntities;
                            patientEntities.pob = value;
                            orderProvider.updateNewPatient(patientEntities);
                          },
                        ),
                        const SizedBox(height: 12),
                        dateFieldWidgetWithBorder(
                          label: "Tanggal Lahir",
                          hintText: "22-02-1992",
                          prefixIcon: const Icon(FeatherIcons.calendar),
                          isUnderline: true,
                          context: context,
                          dateController: dobCtrl,
                          onChanged: (value) {
                            PatientEntities patientEntities =
                                orderProvider.newPatientEntities;
                            patientEntities.dob = value;
                            orderProvider.updateNewPatient(patientEntities);
                          },
                        ),
                        const SizedBox(height: 12),
                        RichText(
                          text: TextSpan(
                            text: "Agama",
                            style: AppTheme.bodyText.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              TextSpan(
                                text: '*',
                                style: AppTheme.bodyText.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField<String>(
                          value: orderProvider.newPatientEntities.religion ??
                              "Pilih",
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                  width: 1, color: AppColors.primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                  width: 1, color: AppColors.primaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                  width: 1, color: AppColors.primaryColor),
                            ),
                          ),
                          onChanged: (value) {
                            PatientEntities patientEntities =
                                orderProvider.newPatientEntities;
                            patientEntities.religion = value;
                            orderProvider.updateNewPatient(patientEntities);
                          },
                          isExpanded: true,
                          items: [
                            "Pilih",
                            "Islam",
                            "Hindu",
                            "Buddha",
                            "Katolik",
                            "Protestan",
                            "Khonghucu",
                          ].map((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 12),
                        RadioButtonGender(
                          gender: orderProvider.newPatientEntities.gender ?? "",
                          onTap: (value) {
                            PatientEntities patientEntities =
                                orderProvider.newPatientEntities;
                            patientEntities.gender = value;
                            orderProvider.updateNewPatient(patientEntities);
                          },
                        ),
                        const SizedBox(height: 20),
                        Buttons(
                            title: "Simpan",
                            onTap: onOrderForOther,
                            loading: orderProvider.requestCreateNewPatientState ==
                                RequestState.Loading,
                            disabled: Helpers.checkIsNull(
                                    orderProvider.newPatientEntities.name) ||
                                Helpers.checkIsNull(orderProvider
                                    .newPatientEntities.domicilieAddress) ||
                                Helpers.checkIsNull(orderProvider
                                    .newPatientEntities.coordinate) ||
                                Helpers.checkIsNull(
                                    orderProvider.newPatientEntities.nik) ||
                                Helpers.checkIsNull(
                                    orderProvider.newPatientEntities.address) ||
                                Helpers.checkIsNull(orderProvider
                                    .newPatientEntities.waNumber) ||
                                Helpers.checkIsNull(orderProvider
                                    .newPatientEntities.phoneNumber) ||
                                Helpers.checkIsNull(orderProvider.newPatientEntities.pob) ||
                                Helpers.checkIsNull(orderProvider.newPatientEntities.dob) ||
                                Helpers.checkIsNull(orderProvider.newPatientEntities.religion) ||
                                Helpers.checkIsNull(orderProvider.newPatientEntities.gender)),
                        const SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    },
  );
}
