import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/data/models/enrollment_model.dart';
import 'package:jd_mobile/domain/entities/patient/patient_entities.dart';
import 'package:jd_mobile/domain/usecases/patient/create_patient.dart';

import '../../../data/models/detail_patient_model.dart';

class PatientProvider extends ChangeNotifier {
  PatientProvider({this.createPatient});

  final CreatePatient? createPatient;
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

  String get errorMessage => _errorMessage;
  RequestState _requestState = RequestState.Empty;

  RequestState get requestState => _requestState;

  void setRequestState(RequestState state) {
    _requestState = state;
    notifyListeners();
  }

  void addStorage() async {
    // Create storage
    const storage = FlutterSecureStorage();
  }

  void setGender(value) {
    gender = value;
    notifyListeners();
  }

  Future<void> patientCreate() async {
    setRequestState(RequestState.Loading);
    final result = await createPatient!(patient);
    result.fold((l) {
      setRequestState(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (r) {
      setRequestState(RequestState.Loaded);
      notifyListeners();
    });
  }

  void setShowBtnEdit(status) {
    showBtnEdit = status;
    notifyListeners();
  }
}
