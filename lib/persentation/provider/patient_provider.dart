import 'package:flutter/material.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/data/models/enrollment_model.dart';
import 'package:jd_mobile/data/models/patient_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jd_mobile/domain/entities/patient_entities.dart';
import 'package:jd_mobile/domain/usecases/patient/create_patient.dart';
import '../../data/models/detail_patient_model.dart';

class PatientProvider extends ChangeNotifier {
  PatientProvider({this.createPatient});

  final CreatePatient? createPatient;

  var loading = false;
  var loadDetail = false;
  var patient = PatientEntities();
  var detailPatient = DetailPatientModel();
  var isNewPatient = true;
  var isInvalidToken = false;
  var enrollment = EnrollmentModel();
  var enrollmentHistory = EnrollmentModel();
  var segmentedControlValue = true;
  String _errorMessage = "";

  String get errorMessage => _errorMessage;
  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  void addStorage() async {
    // Create storage
    const storage = FlutterSecureStorage();
    var auth = await storage.read(key: AppConst.authToken);
  }

  Future<void> patientCreate() async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await createPatient!(patient);
    result.fold((l) {
      _state = RequestState.Error;
      _errorMessage = l.message;
      notifyListeners();
    }, (r) {
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
