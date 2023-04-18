import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jd_mobile/common/helpers/date_helper.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/domain/entities/patient/patient_entities.dart';
import 'package:jd_mobile/persentation/pages/account/components/map/map_page.dart';
import 'package:jd_mobile/persentation/widgets/logo_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_const.dart';
import '../../../common/helpers/helpers.dart';
import '../../../common/resources/snackbar.dart';
import '../../../common/theme/theme.dart';
import '../../../common/utils/state_enum.dart';
import '../../provider/map/map_provider.dart';
import '../../provider/patient/patient_provider.dart';
import '../../widgets/app_bars.dart';
import '../../widgets/buttons.dart';
import '../../widgets/profile_widget.dart';
import '../../widgets/text_field.dart';

class ProfileForm extends StatefulWidget {
  static const routeName = "/ProfileForm";

  const ProfileForm({Key? key}) : super(key: key);

  @override
  ProfileFormState createState() => ProfileFormState();
}

class ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PatientProvider patientProvider =
          Provider.of<PatientProvider>(context, listen: false);
      MapProvider mapProvider =
          Provider.of<MapProvider>(context, listen: false);

      patientProvider.setShowBtnEdit(true);
      if (patientProvider.patient.name?.isEmpty ?? true) {
        patientProvider.setShowBtnEdit(false);
      }

      Future.delayed(const Duration(milliseconds: 200), () async {
        final nrm = (patientProvider.patient.nrm == ""
                ? null
                : patientProvider.patient.nrm) ??
            await Helpers.readLocalStorage(AppConst.NRM_KEY);
        final phone = await Helpers.readLocalStorage(AppConst.PHONE_NUMBER_KEY);
        patientProvider.patient.nrm = nrm;
        patientProvider.patient.waNumber = phone;

        patientProvider.nrmCtrl.text = nrm ?? "";
        patientProvider.waNumberCtrl.text = phone ?? "";
        patientProvider.phoneNumberCtrl.text =
            patientProvider.patient.phoneNumber ?? "";
        patientProvider.nameCtrl.text = patientProvider.patient.name ?? "";
        patientProvider.nikCtrl.text = patientProvider.patient.nik ?? "";
        patientProvider.adressCtrl.text = patientProvider.patient.address ?? "";
        patientProvider.domicilieAdressCtrl.text =
            patientProvider.patient.domicilieAddress ?? "";
        patientProvider.religionCtrl.text =
            patientProvider.patient.religion ?? "";
        patientProvider.pobCtrl.text = patientProvider.patient.pob ?? "";
        patientProvider.dobCtrl.text =
            DateHelper.changeFormatIdToDateTimeFormat(
                    date: DateTime.parse(patientProvider.patient.dob ?? ""),
                    newPatternId: true) ??
                "";
        patientProvider.patient.gender = patientProvider.patient.gender ?? "";
        patientProvider.setGender(patientProvider.patient.gender ?? "");
        if ((patientProvider.patient.coordinate ?? "") != "") {
          List<dynamic> latLng =
              jsonDecode(patientProvider.patient.coordinate!);
          mapProvider.setSelectedPosition(LatLng(
              double.parse(latLng[1].toString()),
              double.parse(latLng[0].toString())));
          mapProvider.getLocation(mapProvider.selectedPosition).then((value) {
            mapProvider.setSelectedDetailAddress(value);
          });
        }

        patientProvider.setWaNumberEqPhoneNumber(
            patientProvider.waNumberCtrl.text ==
                patientProvider.phoneNumberCtrl.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    PatientProvider patientProvider =
        Provider.of<PatientProvider>(context, listen: true);
    MapProvider mapProvider = Provider.of<MapProvider>(context, listen: true);
    return Scaffold(
        appBar: AppsBar(
          elevation: 0.0,
          flexibleSpaceBar: FlexibleSpaceBar(
            centerTitle: true,
            title: Container(
              margin: const EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      size: 32,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  LogoWidget.logoIcon(
                      height: 23, width: 65, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
        body: Transform.translate(
          offset: const Offset(0, -1),
          child: Column(
            children: [
              _buildHeader(patientProvider),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConstants.margin),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: !patientProvider.showBtnEdit,
                              child:
                                  _buildTextField(patientProvider, mapProvider),
                            ),
                            Visibility(
                              visible: patientProvider.showBtnEdit,
                              child: _buildDetailPatient(patientProvider),
                            ),
                            const SizedBox(height: 10),
                            Buttons(
                                title: patientProvider.showBtnEdit
                                    ? "Edit identitas"
                                    : "Simpan",
                                onTap: () {
                                  if (patientProvider.requestState !=
                                      RequestState.Loading) {
                                    if (patientProvider.showBtnEdit == false) {
                                      if ((patientProvider.patient.coordinate ??
                                              "") ==
                                          "") {
                                        SnackBarCustom.showSnackBarMessage(
                                          context: context,
                                          title: "Ops !",
                                          message:
                                              "Pastikan Alamat dengan Maps dipilih",
                                          typeMessage: SnackBarType.error,
                                        );
                                      } else if ((patientProvider
                                                  .patient.gender ??
                                              "") ==
                                          "") {
                                        SnackBarCustom.showSnackBarMessage(
                                          context: context,
                                          title: "Ops !",
                                          message:
                                              "Jenis Kelamin harus dipilih",
                                          typeMessage: SnackBarType.error,
                                        );
                                      } else if (_formKey.currentState!
                                          .validate()) {
                                        Helpers.printDebug("_createOrUpdate()");
                                        _createOrUpdate(patientProvider);
                                      }
                                    }

                                    if (patientProvider.showBtnEdit) {
                                      patientProvider.setShowBtnEdit(false);
                                    }
                                  }
                                },
                                loading: patientProvider.requestState ==
                                    RequestState.Loading,
                                disabled: Helpers.checkIsNull(
                                        patientProvider.patient.name) ||
                                    Helpers.checkIsNull(patientProvider
                                        .patient.domicilieAddress) ||
                                    Helpers.checkIsNull(
                                        patientProvider.patient.coordinate) ||
                                    Helpers.checkIsNull(
                                        patientProvider.patient.nik) ||
                                    (patientProvider.patient.nik != null &&
                                        patientProvider.patient.nik!.length <
                                            16) ||
                                    Helpers.checkIsNull(
                                        patientProvider.patient.address) ||
                                    Helpers.checkIsNull(
                                        patientProvider.patient.waNumber) ||
                                    Helpers.checkIsNull(
                                        patientProvider.patient.phoneNumber) ||
                                    Helpers.checkIsNull(
                                        patientProvider.patient.pob) ||
                                    Helpers.checkIsNull(
                                        patientProvider.patient.dob) ||
                                    Helpers.checkIsNull(
                                        patientProvider.patient.gender)),
                            const SizedBox(height: 16),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _createOrUpdate(PatientProvider patientProvider) {
    FocusScope.of(context).unfocus();

    patientProvider.createOrUpdate().then((value) {
      if (patientProvider.requestState == RequestState.Loaded) {
        patientProvider.setShowBtnEdit(true);
        SnackBarCustom.showSnackBarMessage(
          context: context,
          title: "Berhasil !",
          message:
              "Berhasil ${patientProvider.isNewPatient ? "menyimpan" : "memperbarui"}  data pasien!",
          typeMessage: SnackBarType.success,
        );
      }

      if (patientProvider.requestState == RequestState.Error) {
        SnackBarCustom.showSnackBarMessage(
          context: context,
          title: "Ops !",
          message:
              "Gagal ${patientProvider.isNewPatient ? "menyimpan" : "memperbarui"} data. Coba lagi atau Hubungi Administrator!",
          typeMessage: SnackBarType.error,
        );
      }
    });
  }

  Widget _buildHeader(PatientProvider patientProvider) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Image.asset(
            "${Assets.othersPath}/bg2.png",
            height: 244,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                "Identitas pasien",
                style: AppTheme.subtitle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Silahkan periksa kelengkapan data diri anda",
                textAlign: TextAlign.center,
                style: AppTheme.subtitle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ProfileInitialWidget(
                  size: 90,
                  name: patientProvider.patient.name ?? "",
                  fontSize: 50,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "No rekam medis",
                style: AppTheme.subtitle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                patientProvider.patient.nrm ?? "-",
                style: AppTheme.heading6.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      PatientProvider patientProvider, MapProvider mapProvider) {
    return Column(
      children: [
        const SizedBox(height: 12),
        textFieldWidgetWithBorder(
          label: "Nama Lengkap Pasien",
          hintText: "Nama Kamu",
          isName: true,
          prefixIcon: const Icon(FeatherIcons.user),
          isUnderline: true,
          controller: patientProvider.nameCtrl,
          inputType: TextInputType.text,
          formatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z-" "]')),
          ],
          onChanged: (value) {
            PatientEntities patient = patientProvider.patient;
            patient.name = value;
            patientProvider.updateDataPatient(patient);
          },
        ),
        const SizedBox(height: 12),
        textFieldWidgetWithBorder(
          label: "Alamat Domisili",
          hintText: "Jl. ABC",
          prefixIcon: const Icon(FeatherIcons.mapPin),
          isUnderline: true,
          controller: patientProvider.domicilieAdressCtrl,
          inputType: TextInputType.text,
          onChanged: (value) {
            PatientEntities patient = patientProvider.patient;
            patient.domicilieAddress = value;
            patientProvider.updateDataPatient(patient);
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
                        if (value.latitude != 0 && value.longitude != 0) {
                          List<double> listLatLong = [
                            value.longitude,
                            value.latitude
                          ];
                          PatientEntities patient = patientProvider.patient;
                          patient.coordinate = jsonEncode(listLatLong);
                          patientProvider.updateDataPatient(patient);
                        }
                      })),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                    fontWeight: FontWeight.w400,
                  ),
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
                    style: AppTheme.bodyText
                        .copyWith(fontSize: 10, color: AppColors.primaryColor),
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
          controller: patientProvider.nikCtrl,
          inputType: TextInputType.number,
          formatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {
            PatientEntities patient = patientProvider.patient;
            patient.nik = value;
            patientProvider.updateDataPatient(patient);
          },
        ),
        textFieldWidgetWithBorder(
          label: "Alamat KTP",
          hintText: "Jl. ABC",
          prefixIcon: const Icon(FeatherIcons.map),
          isUnderline: true,
          controller: patientProvider.adressCtrl,
          inputType: TextInputType.text,
          onChanged: (value) {
            PatientEntities patient = patientProvider.patient;
            patient.address = value;
            patientProvider.updateDataPatient(patient);
          },
        ),
        const SizedBox(height: 12),
        textFieldWidgetWithBorder(
          isEnabled: false,
          label: "Nomor Whatsapp",
          hintText: "08123456789",
          prefixIcon: const Icon(FeatherIcons.phone),
          isUnderline: true,
          controller: patientProvider.waNumberCtrl,
          inputType: TextInputType.number,
          formatters: [FilteringTextInputFormatter.digitsOnly],
          isTelephone: true,
          onChanged: (value) {
            patientProvider.patient.waNumber = value;
            PatientEntities patient = patientProvider.patient;
            patient.waNumber = value;
          },
        ),
        Transform.translate(
          offset: const Offset(-10, -20),
          child: ListTileTheme(
            contentPadding: EdgeInsets.zero,
            child: CheckboxListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                "Gunakan Nomor Whatsapp? ",
                style: GoogleFonts.poppins(),
              ),
              value: patientProvider.waNumberEqPhoneNumber,
              onChanged: (checked) {
                patientProvider.setWaNumberEqPhoneNumber(checked ?? false);
                if (patientProvider.waNumberEqPhoneNumber) {
                  patientProvider.phoneNumberCtrl.text =
                      patientProvider.waNumberCtrl.text;
                  PatientEntities patient = patientProvider.patient;
                  patient.phoneNumber = patientProvider.phoneNumberCtrl.text;
                  patientProvider.updateDataPatient(patient);
                } else {
                  patientProvider.phoneNumberCtrl.text = "";
                  PatientEntities patient = patientProvider.patient;
                  patient.phoneNumber = "";
                  patientProvider.updateDataPatient(patient);
                }
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
        ),
        if (!patientProvider.waNumberEqPhoneNumber)
          textFieldWidgetWithBorder(
            label: "Nomor Hp",
            controller: patientProvider.phoneNumberCtrl,
            inputType: TextInputType.number,
            prefixIcon: const Icon(FeatherIcons.phoneCall),
            isUnderline: true,
            isOptional: patientProvider.waNumberEqPhoneNumber,
            formatters: [FilteringTextInputFormatter.digitsOnly],
            isTelephone: true,
            onChanged: (value) {
              PatientEntities patient = patientProvider.patient;
              patient.phoneNumber = value;
              patientProvider.updateDataPatient(patient);
            },
          ),
        Transform.translate(
          offset: const Offset(0, -5),
          child: textFieldWidgetWithBorder(
            label: "Tempat Lahir",
            hintText: "Jakarta",
            controller: patientProvider.pobCtrl,
            prefixIcon: const Icon(FeatherIcons.home),
            isUnderline: true,
            inputType: TextInputType.text,
            onChanged: (value) {
              PatientEntities patient = patientProvider.patient;
              patient.pob = value;
              patientProvider.updateDataPatient(patient);
            },
          ),
        ),
        const SizedBox(height: 12),
        dateFieldWidgetWithBorder(
          label: "Tanggal Lahir",
          hintText: "22-02-1992",
          prefixIcon: const Icon(FeatherIcons.calendar),
          isUnderline: true,
          context: context,
          dateController: patientProvider.dobCtrl,
          onChanged: (value) {
            PatientEntities patient = patientProvider.patient;
            patient.dob = DateHelper.changeFormatIdToDateTimeFormat(
                date: DateHelper.covertStringToDateTime(value: value));
            patientProvider.updateDataPatient(patient);
          },
        ),
        const SizedBox(height: 12),
        _buildGender(patientProvider),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDetailPatient(PatientProvider patientProvider) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        _buildDetailMenu("Nama lengkap", patientProvider.patient.name ?? "-"),
        _buildDetailMenu("NIK", patientProvider.patient.nik ?? "-"),
        _buildDetailMenu(
            "Alamat Domisili", patientProvider.patient.domicilieAddress ?? "-"),
        _buildDetailMenu("Alamat KTP", patientProvider.patient.address ?? "-"),
        _buildDetailMenu(
            "Jenis Kelamin", getGender(patientProvider.patient.gender)),
        _buildDetailMenu("Tempat Lahir", patientProvider.patient.pob ?? "-"),
        _buildDetailMenu(
            "Tanggal Lahir",
            DateHelper.changeFormatIdToDateTimeFormat(
                    date: DateHelper.covertStringToDateTime(
                        value: patientProvider.patient.dob ?? ""),
                    newPatternId: true) ??
                "-"),
        _buildDetailMenu(
            "Nomor Whatsapp", patientProvider.patient.waNumber ?? "-"),
      ],
    );
  }

  Widget _buildDetailMenu(String key, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.grey200Color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              child: Text(
                key,
                style: AppTheme.subtitle.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12),
              )),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTheme.subtitle.copyWith(
                  color: AppColors.primaryColorDarkColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGender(PatientProvider patientProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Jenis Kelamin",
            style: AppTheme.bodyText.copyWith(
                color: AppColors.primaryColorDarkColor,
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
        Transform.translate(
          offset: const Offset(-10, -5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: RadioListTile(
                  title: Transform.translate(
                    offset: const Offset(-15, 0),
                    child: Text(
                      'Laki-laki',
                      style: AppTheme.bodyText.copyWith(
                          fontSize: 14,
                          color: const Color(0XFF27272E),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  value: "male",
                  selected: (patientProvider.patient.gender ?? "") == "male",
                  groupValue: patientProvider.gender,
                  activeColor: const Color(0XFF051033),
                  selectedTileColor: const Color(0XFF051033),
                  tileColor: const Color(0XFF4A5568),
                  contentPadding: const EdgeInsets.all(0),
                  onChanged: (value) {
                    patientProvider.setGender(value.toString());
                    patientProvider.patient.gender = value.toString();
                    PatientEntities patient = patientProvider.patient;
                    patient.gender = value.toString();
                    patientProvider.updateDataPatient(patient);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: RadioListTile(
                  title: Transform.translate(
                    offset: const Offset(-15, 0),
                    child: Text(
                      'Perempuan',
                      style: AppTheme.bodyText.copyWith(
                          fontSize: 14,
                          color: const Color(0XFF27272E),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  value: "female",
                  selected: (patientProvider.patient.gender ?? "") == "female",
                  groupValue: patientProvider.gender,
                  activeColor: const Color(0XFF051033),
                  selectedTileColor: const Color(0XFF051033),
                  tileColor: const Color(0XFF4A5568),
                  contentPadding: const EdgeInsets.all(0),
                  onChanged: (value) {
                    patientProvider.setGender(value.toString());
                    patientProvider.patient.gender = value.toString();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getGender(String? value) {
    if (value == null) return "-";

    if (value == "male") {
      return "Laki-laki";
    } else if (value == "female") {
      return "Perempuan";
    } else {
      return "-";
    }
  }
}
