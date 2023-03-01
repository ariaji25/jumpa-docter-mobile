import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/data/models/booking/booking_model.dart';
import 'package:jd_mobile/data/models/patient/detail_patient_model.dart';
import 'package:jd_mobile/data/models/patient/patient_model.dart';
import 'package:jd_mobile/domain/entities/booking/booking_enitites.dart';
import 'package:jd_mobile/domain/usecases/patient/detail_patient_by_nrm.dart';
import 'package:logger/logger.dart';

class OrderProvider extends ChangeNotifier {
  final DetailPatientByNrm detailPatientByNrm;
  OrderProvider({required this.detailPatientByNrm});

  final storage = const FlutterSecureStorage();
  final bookingEntites = BookingEntites();

  // Check NIK Patient
  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  RequestState _requestState = RequestState.Empty;
  RequestState get requestState => _requestState;

  String? _nikPatient;
  String? get nikPatient => _nikPatient;

  Future<void> checkNikPatient() async {
    _requestState = RequestState.Loading;
    notifyListeners();

    String? phoneNumber = await storage.read(key: AppConst.PHONE_NUMBER_KEY);
    final result = await detailPatientByNrm(phoneNumber ?? "");
    result.fold((l) {
      _requestState = RequestState.Error;
      _errorMessage = l.message;
      notifyListeners();
    }, (r) {
      final res = DetailPatientModel.fromJson(jsonDecode(r))
          .trackedEntityInstances?[0]
          .attributes;

      final PatientModel dataPatient = PatientModel.fromAttributes(res ?? []);
      _nikPatient = dataPatient.nik;

      _requestState = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future createBooking() async {
    log(bookingEntites.complaint.toString());
    Logger().d(BookingModel.formEntities(bookingEntites).toJson());
  }
}
