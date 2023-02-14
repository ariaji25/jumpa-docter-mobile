import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/domain/entities/patient/patient_entities.dart';
import 'package:jd_mobile/domain/usecases/patient/create_patient.dart';
import 'package:jd_mobile/domain/usecases/patient/create_patient_nrm.dart';
import 'package:jd_mobile/domain/usecases/patient/detail_patient_by_nrm.dart';
import 'package:jd_mobile/domain/usecases/patient/update_patient.dart';

import '../../../common/helpers/helpers.dart';
import '../../../data/models/patient/detail_patient_model.dart';
import '../../../data/models/patient/enrollment_model.dart';
import '../../../data/models/patient/patient_model.dart';

class PatientProvider extends ChangeNotifier {
  PatientProvider(
      {this.createPatient,
      this.createPatientNrm,
      this.updatePatient,
      this.detailPatientByNrm});

  final CreatePatient? createPatient;
  final CreatePatientNrm? createPatientNrm;
  final UpdatePatient? updatePatient;
  final DetailPatientByNrm? detailPatientByNrm;
  final TextEditingController nrmCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController nikCtrl = TextEditingController();
  final TextEditingController adressCtrl = TextEditingController();
  final TextEditingController domicilieAdressCtrl = TextEditingController();
  final TextEditingController phoneNumberCtrl = TextEditingController();
  final TextEditingController waNumberCtrl = TextEditingController();
  final TextEditingController religionCtrl = TextEditingController();
  final TextEditingController pobCtrl = TextEditingController();
  final TextEditingController dobCtrl = TextEditingController();

  // Use phone number as wa number
  bool waNumberEqPhoneNumber = false;
  final storage = const FlutterSecureStorage();
  var loadDetail = false;
  var patient = PatientEntities();
  var detailPatient = DetailPatientModel();
  var isNewPatient = true;
  var isInvalidToken = false;
  var enrollment = EnrollmentModel();
  var enrollmentHistory = EnrollmentModel();
  var segmentedControlValue = true;
  var showBtnEdit = true;
  String gender = "";
  String _errorMessage = "";
  String? nrmPatient;

  String get errorMessage => _errorMessage;
  RequestState _requestState = RequestState.Empty;

  RequestState get requestState => _requestState;

  void setRequestState(RequestState state) {
    _requestState = state;
    notifyListeners();
  }

  void setGender(value) {
    gender = value;
    notifyListeners();
  }

  void setShowBtnEdit(value) {
    showBtnEdit = value;
    notifyListeners();
  }

  void setWaNumberEqPhoneNumber(value) {
    waNumberEqPhoneNumber = value;
    notifyListeners();
  }

  void setNrmPatient(value) {
    nrmPatient = value;
    notifyListeners();
  }

  void setIsInvalidToken(value) {
    isInvalidToken = value;
    notifyListeners();
  }

  Future<void> patientCreateNrm() async {
    final result = await createPatientNrm!({
      "name": patient.name,
      "orgUnit": "ZxIltg4P06f",
    });
    result.fold((l) {
      setRequestState(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (r) async {
      patient.nrm = r;
      notifyListeners();
      await Helpers.writeLocalStorage(AppConst.NRM_KEY, r);
      await patientCreate();
    });
  }

  Future<void> patientCreate() async {
    setRequestState(RequestState.Loading);
    final result = await createPatient!(patient);
    result.fold((l) {
      setRequestState(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (r) async {
      isNewPatient = false;
      notifyListeners();
      storage.write(key: AppConst.TEI_KEY, value: r);
      await patientDetailByNrm();
    });
  }

  Future<void> patientUpdate() async {
    setRequestState(RequestState.Loading);
    final detail = detailPatient.trackedEntityInstances?.first;
    if (detail != null) {
      final result = await updatePatient!({
        "trackedEntityInstance": detail.trackedEntityInstance,
        "orgUnit": detail.orgUnit,
        "attributes": [
          {"attribute": "HyfzjNVhlzM", "value": "${patient.name}"},
          {"attribute": "NCLBUYYxnWU", "value": "${patient.phoneNumber}"},
          {"attribute": "Q3tLvwl4Ttq", "value": "${patient.address}"},
          {"attribute": "Qtjs7yonSYc", "value": "${patient.pob}"},
          {"attribute": "SSsiEz3cVbn", "value": "${patient.dob}"},
          {"attribute": "TlO4kdMfHqa", "value": "${patient.gender}"},
          {"attribute": "aRHSGgFeOjr", "value": "${patient.domicilieAddress}"},
          {"attribute": "k3TvJYe6jBT", "value": "${patient.religion}"},
          {"attribute": "kOJUHSrbkBS", "value": "${patient.nrm}"},
          {"attribute": "x9tchw0swEu", "value": "${patient.waNumber}"},
          {"attribute": "xGjeKnsJobT", "value": "${patient.nik}"},
          {
            "attribute": PatientKeys.coordinate,
            "valueType": "COORDINATE",
            "value": "${patient.coordinate}"
          },
        ],
      });
      result.fold((l) {
        setRequestState(RequestState.Error);
        _errorMessage = l.message;
        notifyListeners();
      }, (r) {
        setRequestState(RequestState.Loaded);
      });
    }
  }

  Future<void> patientDetailByNrm() async {
    String? phoneNumber = await storage.read(key: AppConst.PHONE_NUMBER_KEY);
    final result = await detailPatientByNrm!(phoneNumber ?? "");
    result.fold((l) {
      setRequestState(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
      if (l.message == AppConst.INVALID_TOKEN ||
          l.message == AppConst.INVALID_TOKEN_OTHER) {
        setIsInvalidToken(true);
      }
    }, (r) {
      DetailPatientModel res = DetailPatientModel.fromJson(jsonDecode(r));
      detailPatient = res;
      notifyListeners();
      // Wrap detail patient if any
      if (res.trackedEntityInstances != null &&
          res.trackedEntityInstances!.isNotEmpty &&
          res.trackedEntityInstances![0].trackedEntityInstance != null) {
        isNewPatient = false;
        notifyListeners();

        final teiRef = res.trackedEntityInstances![0].trackedEntityInstance;
        notifyListeners();
        storage.write(key: AppConst.TEI_KEY, value: teiRef);

        final patientAttributes = PatientModel.fromAttributes(
          res.trackedEntityInstances![0].attributes ?? [],
        );
        notifyListeners();

        patientAttributes.tei = teiRef;
        notifyListeners();
        patient = patientAttributes;
        notifyListeners();

        storage.write(
            key: AppConst.CURRENT_USER,
            value: PatientModel.fromEntities(patient).toStorage().toString());
        setRequestState(RequestState.Loaded);
      }
    });
  }

  Future createOrUpdate() async {
    setRequestState(RequestState.Loading);
    if (isNewPatient) {
      // ASIGN NEW NRM
      await patientCreateNrm();
      setRequestState(RequestState.Loaded);
    } else {
      await patientUpdate();
    }
  }
}
