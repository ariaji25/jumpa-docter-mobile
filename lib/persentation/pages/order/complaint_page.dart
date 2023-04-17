import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/snackbar.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/domain/entities/booking/booking_enitities.dart';
import 'package:jd_mobile/domain/entities/patient/patient_entities.dart';
import 'package:jd_mobile/domain/entities/services_jd/service_jd_entities.dart';
import 'package:jd_mobile/persentation/pages/order/components/base_screen_order.dart';
import 'package:jd_mobile/persentation/pages/order/components/button_item_selected.dart';
import 'package:jd_mobile/persentation/pages/order/doctor_page.dart';
import 'package:jd_mobile/persentation/provider/map/map_provider.dart';
import 'package:jd_mobile/persentation/provider/patient/patient_provider.dart';
import 'package:jd_mobile/persentation/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/state_enum.dart';
import '../../provider/order/order_provider.dart';
import '../../widgets/confirm_modal.dart';
import 'components/for_other_widget.dart';
import 'components/new_patient.dart';

class ComplaintPage extends StatefulWidget {
  static const routeName = "/ComplaintPage";

  const ComplaintPage({super.key});

  @override
  State<StatefulWidget> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  late MapProvider mapProvider;
  late PatientProvider patientProvider;
  late OrderProvider orderProvider;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final formKeyNewPatient = GlobalKey<FormState>();

  @override
  void initState() {
    mapProvider = Provider.of<MapProvider>(context, listen: false);
    patientProvider = Provider.of<PatientProvider>(context, listen: false);
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 0), () async {
      orderProvider.checkNikPatient();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final params = ModalRoute.of(context)?.settings.arguments
        as JumpaDokterServiceEntities;
    Future.delayed(const Duration(seconds: 0), () async {
      orderProvider.setServiceId(params.serviceId);
      orderProvider.bookingEntities.service = params.title;
      BookingEntities bookingEntities = orderProvider.bookingEntities;
      bookingEntities.orderType = "Diri Sendiri";
      orderProvider.updateBooking(bookingEntities);
    });

    return BaseOrderScreen(
        title: params.title == "Swab Antigen"
            ? "Tujuan SWAB Antigen"
            : "Detail Keluhan",
        subTitle: params.title == "Swab Antigen"
            ? ""
            : "Tambahkan rincian keluhan anda",
        btnTitle: "Lanjut",
        onNext: () {
          if (orderProvider.patientEntities.nik == null ||
              orderProvider.patientEntities.name == null) {
            messageRequired("Pastikan pasien tidak kosong");
          } else if (formKey.currentState!.validate()) {
            Navigator.pushNamed(context, DoctorPage.routeName);
          }
        },
        onBack: _onCancelOrder,
        loading: false,
        disabled: Provider.of<OrderProvider>(context, listen: true)
                    .patientEntities
                    .nik ==
                null ||
            Provider.of<OrderProvider>(context, listen: true)
                    .patientEntities
                    .name ==
                null ||
            Provider.of<OrderProvider>(context, listen: true)
                    .complaintCtrl
                    .text ==
                "",
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
              key: formKey,
              child: textFieldWidgetWithBorder(
                label: params.title == "Swab Antigen"
                    ? "Tujuan Swab Antigen"
                    : "Keluhan yang anda rasakan",
                controller: orderProvider.complaintCtrl,
                inputType: TextInputType.text,
                maxLines: 8,
                minLines: 8,
                isShowingLable: false,
                onChanged: (value) {
                  BookingEntities bookingEntities =
                      orderProvider.bookingEntities;
                  bookingEntities.complaint = value;
                  orderProvider.updateBooking(bookingEntities);
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
            Consumer<OrderProvider>(builder: (context, orderProvider, child) {
              return Row(
                children: [
                  ButtonItemSelect(
                    title: "Diri Sendiri",
                    borderRadius: 6,
                    isSelected: orderProvider.orderFor == 0,
                    onTap: () {
                      _onSelectedOrderFor(0, "Diri Sendiri");
                    },
                  ),
                  const SizedBox(width: 18),
                  ButtonItemSelect(
                    title: "Orang Lain",
                    borderRadius: 6,
                    isSelected: orderProvider.orderFor == 1,
                    onTap: () {
                      _onSelectedOrderFor(1, "Orang Lain");
                    },
                  ),
                ],
              );
            }),
            const SizedBox(height: 25),
            Consumer<OrderProvider>(builder: (context, orderProvider, child) {
              return Visibility(
                visible: orderProvider.orderFor == 1,
                child: ForOtherWidget(
                  patientType: orderProvider.patientType,
                  orderProvider: orderProvider,
                  onNewPatient: () {
                    _onSelectedPatientType(0);
                    mapProvider.setSelectedDetailAddress("");
                    mapProvider.setSelectedPosition(const LatLng(0, 0));
                    return bottomSheetPatientWidget(
                        context,
                        _onCheckUseWaNumber,
                        orderProvider.phoneNumberCtrl,
                        orderProvider.dobCtrl,
                        _onCreateNewPatient,
                        formKeyNewPatient);
                  },
                  onExistingPatient: () {
                    _onSelectedPatientType(1);
                  },
                  onSearch: (val) {
                    if (val.isEmpty) {
                      SnackBarCustom.showSnackBarMessage(
                          context: context,
                          title: "Peringatan",
                          message: "NIK tidak boleh kosong",
                          typeMessage: SnackBarType.warning);
                    } else if (val.isNotEmpty && val.length != 16) {
                      SnackBarCustom.showSnackBarMessage(
                          context: context,
                          title: "Peringatan",
                          message: "Panjang NIK wajib 16",
                          typeMessage: SnackBarType.warning);
                    } else {
                      orderProvider.setSearch(val);
                      // Reload on search
                      getPatientByNIK();
                    }
                  },
                ),
              );
            }),
            Consumer<OrderProvider>(builder: (context, orderProvider, child) {
              return Visibility(
                visible: orderProvider.orderFor == 0,
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
                    Row(
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
                    )
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),
          ],
        ));
  }

  void _onSelectedOrderFor(int t, String s) {
    orderProvider.setOrderFor(t);
    BookingEntities bookingEntities = orderProvider.bookingEntities;
    bookingEntities.orderType = s;
    orderProvider.updateBooking(bookingEntities);
    orderProvider
        .updatePatient(t == 0 ? patientProvider.patient : PatientEntities());
  }

  void _onSelectedPatientType(int t) {
    orderProvider.setPatientType(t);
    orderProvider.updatePatient(PatientEntities());
  }

  void getPatientByNIK() {
    orderProvider.getPatientByNIK();
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
    orderProvider.setWaNumberEqPhoneNumber(checked ?? false);
    PatientEntities patientEntities = orderProvider.patientEntities;
    patientEntities.phoneNumber = orderProvider.phoneNumberCtrl.text;
    orderProvider.updatePatient(patientEntities);
  }

  _onCreateNewPatient() {
    if (formKeyNewPatient.currentState!.validate()) {
      if ((orderProvider.newPatientEntities.coordinate ?? "") == "") {
        messageRequired("Pastikan Alamat dengan Maps dipilih");
      } else if ((orderProvider.newPatientEntities.religion ?? "") == "") {
        messageRequired("Agama wajib dipilih");
      } else if ((orderProvider.newPatientEntities.gender ?? "") == "") {
        messageRequired("Jenis Kelamin wajib dipilih");
      } else {
        confirmModal(
          context,
          "Anda yakin ingin melanjutkan ? ",
          "Data pasien akan kami simpan untuk mendapatkan Nomor Rekam Medis.\n\n"
              "Pastikan Nomor Handphone (HP) pasien sudah sesuai.",
          onOk: () {
            _createPatient();
          },
        );
      }
    }
  }

  _createPatient() {
    orderProvider.createNewPatient().then((value) {
      Navigator.of(context).pop();

      if (orderProvider.requestCreateNewPatientState == RequestState.Loaded) {
        orderProvider.setWaNumberEqPhoneNumber(false);
        orderProvider.setDobCtrl(TextEditingController());
        mapProvider.setSelectedPosition(const LatLng(0, 0));
        mapProvider.setSelectedDetailAddress("");

        if (!orderProvider.newPatientAlreadyExist) {
          SnackBarCustom.showSnackBarMessage(
              context: context,
              title: "Berhasil !",
              message: "Data Pasien berhasil disimpan.",
              typeMessage: SnackBarType.success);
        } else {
          orderProvider.setPatientType(null);
          Alerts.showAlertDialogExsistingAccount(context);
        }
      } else {
        orderProvider.setPatientType(null);
        SnackBarCustom.showSnackBarMessage(
            context: context,
            title: "Perhatian !",
            message: orderProvider.errorMessage,
            typeMessage: SnackBarType.warning);
        orderProvider.setErrorMessage('');
      }
    });
  }

  void messageRequired(String message) {
    SnackBarCustom.showSnackBarMessage(
        context: context,
        title: "Perhatian !",
        message: message,
        typeMessage: SnackBarType.warning);
  }
}
