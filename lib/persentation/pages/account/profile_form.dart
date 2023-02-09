import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/domain/entities/patient_entities.dart';
import 'package:jd_mobile/persentation/pages/account/components/map/map_page.dart';
import 'package:jd_mobile/persentation/provider/map_provider.dart';
import 'package:jd_mobile/persentation/widgets/logo_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_const.dart';
import '../../../common/helpers/helpers.dart';
import '../../../common/resources/snackbar.dart';
import '../../../common/theme/theme.dart';
import '../../provider/patient_provider.dart';
import '../../widgets/app_bars.dart';
import '../../widgets/loading.dart';
import '../../widgets/text_field.dart';

class ProfileForm extends StatefulWidget {
  static const routeName = "/ProfileForm";

  const ProfileForm({Key? key}) : super(key: key);

  @override
  ProfileFormState createState() => ProfileFormState();
}

class ProfileFormState extends State<ProfileForm> {
  final TextEditingController _nrmCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _nikCtrl = TextEditingController();
  final TextEditingController _adressCtrl = TextEditingController();
  final TextEditingController _domicilieAdressCtrl = TextEditingController();
  final TextEditingController _phoneNumberCtrl = TextEditingController();
  final TextEditingController _waNumberCtrl = TextEditingController();
  final TextEditingController _religionCtrl = TextEditingController();
  final TextEditingController _pobCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  String gender = "";

  // Use phone number as wa number
  bool waNumberEqPhoneNumber = false;
  final _formKey = GlobalKey<FormState>();
  bool _showBtnEdit = true;
  var patient;
  var map;

  @override
  void initState() {
    super.initState();
    patient = Provider.of<PatientProvider>(context, listen: false);
    map = Provider.of<MapProvider>(context, listen: false);
    if (patient.patient.name?.isEmpty ?? true) {
      setState(() {
        _showBtnEdit = false;
      });
    }

    Future.delayed(const Duration(milliseconds: 200), () async {
      final nrm = await Helpers.readLocalStorage(AppConst.nrmKey);
      final phone = await Helpers.readLocalStorage(AppConst.phoneKey);
      patient.patient.nrm = nrm;
      patient.patient.waNumber = phone;

      _nrmCtrl.text = nrm ?? "";
      _waNumberCtrl.text = phone ?? "";
      _phoneNumberCtrl.text = patient.patient.phoneNumber ?? "";
      _nameCtrl.text = patient.patient.name ?? "";
      _nikCtrl.text = patient.patient.nik ?? "";
      _adressCtrl.text = patient.patient.address ?? "";
      _domicilieAdressCtrl.text = patient.patient.domicilieAddress ?? "";
      _religionCtrl.text = patient.patient.religion ?? "";
      _pobCtrl.text = patient.patient.pob ?? "";
      _dobCtrl.text = patient.patient.dob ?? "";
      gender = patient.patient.gender ?? "";
      if ((patient.patient.coordinate ?? "") != "") {
        List<dynamic> latLng = jsonDecode(patient.patient.coordinate!);
        map.selectedPosition = LatLng(double.parse(latLng[1].toString()),
            double.parse(latLng[0].toString()));
        map.getLocation(map.selectedPosition).then((value) {
          map.selectedDetailAddress = value;
        });
      }

      setState(() {
        waNumberEqPhoneNumber = _waNumberCtrl.text == _phoneNumberCtrl.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    Navigator.of(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: AppColors.whiteColor,
                  ),
                ),
                LogoWidget.logoIcon(height: 23, width: 65, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
      body: Consumer<PatientProvider>(builder: (context, patient, child) {
        return Transform.translate(
          offset: const Offset(0, -1),
          child: Column(
            children: [
              _buildHeader(),
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
                              visible: !_showBtnEdit,
                              child: _buildTextfield(patient.patient),
                            ),
                            Visibility(
                              visible: _showBtnEdit,
                              child: _buildDetailPatient(),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                if (_showBtnEdit == false) {
                                  if ((patient.patient.coordinate ?? "") ==
                                      "") {
                                    SnackBarCustom.showSnackBarMessage(
                                      context: context,
                                      title: "Ops !",
                                      message:
                                          "Pastikan Alamat dengan Maps dipilih",
                                      typeMessage: SnackBarType.error,
                                    );
                                  } else if ((patient.patient.gender ?? "") ==
                                          "" &&
                                      false) {
                                    SnackBarCustom.showSnackBarMessage(
                                      context: context,
                                      title: "Ops !",
                                      message: "Jenis Kelamin harus dipilih",
                                      typeMessage: SnackBarType.error,
                                    );
                                  } else if (_formKey.currentState!
                                      .validate()) {
                                    Helpers.printDebug("_createOrUpdate()");
                                    _createOrUpdate();
                                  }
                                }

                                if (_showBtnEdit) {
                                  Helpers.printDebug("_showBtnEdit");
                                  setState(() {
                                    _showBtnEdit = false;
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                height: 40,
                                child: Center(
                                  child: patient.loading
                                      ? const Loading(
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      : Text(
                                          _showBtnEdit
                                              ? "Edit identitas"
                                              : "Simpan",
                                          style: AppTheme.subtitle.copyWith(
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                ),
                              ),
                            ),
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
        );
      }),
    );
  }

  void _createOrUpdate() {
    FocusScope.of(context).unfocus();

    patient.patientCreate().then((value) {
      if (patient.success.isTrue) {
        patient.success = false;
        SnackBarCustom.showSnackBarMessage(
          context: context,
          title: "Berhasil !",
          message:
              "Berhasil ${patient.isNewPatient.isTrue ? "menyimpan" : "memperbarui"}  data pasien!",
          typeMessage: SnackBarType.success,
        );
      } else {
        SnackBarCustom.showSnackBarMessage(
          context: context,
          title: "Ops !",
          message:
              "Gagal menyimpan data. Coba lagi atau Hubungi Administrator!",
          typeMessage: SnackBarType.error,
        );
      }
    });
  }

  Widget _buildHeader() {
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
                "Sebelum melakukan janji temu bersama dokter\nsilahkan terlebih dahulu mengisikan data diri.",
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
                child: Container(
                  width: 90,
                  height: 90,
                  color: Colors.transparent,
                  child: const Icon(
                    Icons.account_circle,
                    size: 91,
                    color: AppColors.whiteColor,
                  ),
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
                patient.patient.nrm ?? "-",
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

  Widget _buildTextfield(PatientEntities patient) {
    return Column(
      children: [
        const SizedBox(height: 12),
        textFieldWidgetWithBorder(
          label: "Nama Lengkap Pasien",
          hintText: "Nama Kamu",
          isName: true,
          prefixIcon: const Icon(FeatherIcons.user),
          isUnderline: true,
          controller: _nameCtrl,
          inputType: TextInputType.text,
          formatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z-" "]')),
          ],
          onChanged: (value) {
            patient.name = value;
          },
        ),
        const SizedBox(height: 12),
        textFieldWidgetWithBorder(
          label: "Alamat Domisili",
          hintText: "Jl. ABC",
          prefixIcon: const Icon(FeatherIcons.mapPin),
          isUnderline: true,
          controller: _domicilieAdressCtrl,
          inputType: TextInputType.text,
          onChanged: (value) {
            patient.domicilieAddress = value;
          },
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: () {
            String latLang = "";
            if (map.selectedPosition.latitude != 0 &&
                map.selectedPosition.longitude != 0) {
              latLang =
                  '${map.selectedPosition.latitude},${map.selectedPosition.longitude}';
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MapPage(
                      latLng: latLang,
                      onTap: (value) {
                        // patient.patient.update((val) {
                        //   if (value.latitude != 0 && value.longitude != 0) {
                        List<double> listLatLong = [
                          value.longitude,
                          value.latitude
                        ];
                        patient.coordinate = jsonEncode(listLatLong);
                        //   }
                        // });
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
          visible: map.selectedDetailAddress != "",
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
                    map.selectedDetailAddress,
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
          controller: _nikCtrl,
          inputType: TextInputType.number,
          formatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {
            // patient.patient.update((val) {
            //   val?.nik = value;
            // });
          },
        ),
        textFieldWidgetWithBorder(
          label: "Alamat KTP",
          hintText: "Jl. ABC",
          prefixIcon: const Icon(FeatherIcons.map),
          isUnderline: true,
          controller: _adressCtrl,
          inputType: TextInputType.text,
          onChanged: (value) {
            // patient.patient.update((val) {
            //   val?.address = value;
            // });
          },
        ),
        const SizedBox(height: 12),
        textFieldWidgetWithBorder(
          isEnabled: false,
          label: "Nomor Whatsapp",
          hintText: "08123456789",
          prefixIcon: const Icon(FeatherIcons.phone),
          isUnderline: true,
          controller: _waNumberCtrl,
          inputType: TextInputType.number,
          formatters: [FilteringTextInputFormatter.digitsOnly],
          isTelephone: true,
          onChanged: (value) {
            // patient.patient.update((val) {
            //   val?.waNumber = value;
            // });
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
              value: waNumberEqPhoneNumber,
              onChanged: (checked) {
                setState(() {
                  waNumberEqPhoneNumber = checked ?? false;

                  if (waNumberEqPhoneNumber) {
                    _phoneNumberCtrl.text = _waNumberCtrl.text;
                    // patient.patient.update((val) {
                    //   val?.phoneNumber = _phoneNumberCtrl.text;
                    // });
                  } else {
                    _phoneNumberCtrl.text = "";
                  }
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
        ),
        if (!waNumberEqPhoneNumber)
          textFieldWidgetWithBorder(
            label: "Nomor Hp",
            controller: _phoneNumberCtrl,
            inputType: TextInputType.number,
            prefixIcon: const Icon(FeatherIcons.phoneCall),
            isUnderline: true,
            isOptional: waNumberEqPhoneNumber,
            formatters: [FilteringTextInputFormatter.digitsOnly],
            isTelephone: true,
            onChanged: (value) {
              // patient.patient.update((val) {
              //   val?.phoneNumber = value;
              // });
            },
          ),
        Transform.translate(
          offset: const Offset(0, -5),
          child: textFieldWidgetWithBorder(
            label: "Tempat Lahir",
            hintText: "Jakarta",
            controller: _pobCtrl,
            prefixIcon: const Icon(FeatherIcons.home),
            isUnderline: true,
            inputType: TextInputType.text,
            onChanged: (value) {
              // patient.patient.update((val) {
              //   val?.pob = value;
              // });
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
          dateController: _dobCtrl,
          onChanged: (value) {
            // patient.patient.update((val) {
            //   val?.dob = value;
            // });
          },
        ),
        const SizedBox(height: 12),
        _buildGender(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDetailPatient() {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        _buildDetailMenu("Nama lengkap", patient.patient.name ?? "-"),
        _buildDetailMenu("NIK", patient.patient.nik ?? "-"),
        _buildDetailMenu(
            "Alamat Domisili", patient.patient.domicilieAddress ?? "-"),
        _buildDetailMenu("Alamat KTP", patient.patient.address ?? "-"),
        _buildDetailMenu("Jenis Kelamin", getGender(patient.patient.gender)),
        _buildDetailMenu("Tempat Lahir", patient.patient.pob ?? "-"),
        _buildDetailMenu("Tanggal Lahir", patient.patient.dob ?? "-"),
        _buildDetailMenu("Nomor Whatsapp", patient.patient.waNumber ?? "-"),
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

  Widget _buildGender() {
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
                  selected: (patient.patient.gender ?? "") == "male",
                  groupValue: gender,
                  activeColor: const Color(0XFF051033),
                  selectedTileColor: const Color(0XFF051033),
                  tileColor: const Color(0XFF4A5568),
                  contentPadding: const EdgeInsets.all(0),
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                      patient.patient.update((val) {
                        val?.gender = value.toString();
                      });
                    });
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
                  selected: (patient.patient.gender ?? "") == "female",
                  groupValue: gender,
                  activeColor: const Color(0XFF051033),
                  selectedTileColor: const Color(0XFF051033),
                  tileColor: const Color(0XFF4A5568),
                  contentPadding: const EdgeInsets.all(0),
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                      patient.patient.update((val) {
                        val?.gender = value.toString();
                      });
                    });
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
