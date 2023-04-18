import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jd_mobile/common/extensions/entities_ext.dart';
import 'package:jd_mobile/domain/entities/patient/enrollment_entities.dart';
import 'package:jd_mobile/domain/usecases/patient/detail_patient_by_nik_other.dart';
import 'package:jd_mobile/domain/usecases/schedule/get_detail_enrollment.dart';
import 'package:jd_mobile/domain/usecases/schedule/get_enrollments.dart';
import 'package:jd_mobile/domain/usecases/schedule/get_history_enrollments.dart';

import '../../../common/utils/state_enum.dart';
import '../../../domain/entities/patient/event_entities.dart';

class ScheduleProvider extends ChangeNotifier {
  ScheduleProvider({
    required this.getEnrollments,
    required this.getHistoryEnrollments,
    required this.getDetailEnrollment,
    required this.detailPatientByNik,
  });

  GetEnrollments getEnrollments;
  GetHistoryEnrollments getHistoryEnrollments;
  GetDetailEnrollment getDetailEnrollment;
  DetailPatientByNikOther detailPatientByNik;
  var enrollment = EnrollmentEntities();
  var enrollmentHistory = EnrollmentEntities();
  var detailEnrollment = EnrollmentEntities();
  String _errorMessage = "";
  RequestState _requestState = RequestState.Loading;
  RequestState _requestStateDetailEnrollment = RequestState.Loading;

  RequestState get requestState => _requestState;

  RequestState get requestStateDetailEnrollment =>
      _requestStateDetailEnrollment;

  String get errorMessage => _errorMessage;

  void setRequestState(RequestState state) {
    _requestState = state;
    notifyListeners();
  }

  void setRequestStateDetailEnrollment(RequestState state) {
    _requestStateDetailEnrollment = state;
    notifyListeners();
  }

  void setErrorMessage(String status) {
    _errorMessage = status;
    notifyListeners();
  }

  Future<void> getListEnrollments(String patientId) async {
    setRequestState(RequestState.Loading);
    final result = await getEnrollments(patientId);
    result.fold((l) {
      setRequestState(RequestState.Error);
      setErrorMessage(l.message);
    }, (r) async {
      await filterDataEnrollment(r);
      setRequestState(RequestState.Loaded);
    });
  }

  Future<void> getListHistoryEnrollments(String patientId) async {
    setRequestState(RequestState.Loading);
    final result = await getHistoryEnrollments(patientId);
    result.fold((l) {
      setRequestState(RequestState.Error);
      setErrorMessage(l.message);
    }, (r) async {
      enrollmentHistory.events = r;
      notifyListeners();
      setRequestState(RequestState.Loaded);
    });
  }

  Future<void> getEnrollmentDetail(String eventId, String nrm, address) async {
    setRequestStateDetailEnrollment(RequestState.Loading);
    final result = await getDetailEnrollment(eventId);
    result.fold((l) {
      setRequestStateDetailEnrollment(RequestState.Error);
      setErrorMessage(l.message);
    }, (r) async {
      List<EventEntities>? events = [];
      if (r.isNotEmpty) {
        events.add(EventEntities(
            dataValues: r[0].dataValues, nrm: nrm, addressPatient: address));
        detailEnrollment.events = [];
        detailEnrollment.events = events;
        notifyListeners();
        setRequestStateDetailEnrollment(RequestState.Loaded);
      }
    });
  }

  Future<void> patientDetailByNIK(String eventId, String nik) async {
    final result = await detailPatientByNik(nik);
    result.fold((l) {
      setRequestState(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (r) async {
      dynamic res = jsonDecode(r);
      Map<String, dynamic> data = {};
      if (res['rows'] != null && res['rows'][0].isNotEmpty) {
        if (res['rows'][0][8] != null) {
          data['nrm'] = res['rows'][0][8];
        }
        if (res['rows'][0][15] != null) {
          data['patient_address'] = res['rows'][0][15];
        }
      }
      await getEnrollmentDetail(eventId, data['nrm'], data['patient_address']);
    });
  }

  filterDataEnrollment(List<EventEntities> data) {
    enrollment.events = [];
    enrollmentHistory.events = [];
    for (var i = 0; i < data.length; i++) {
      DateTime currentNow = DateTime.now();
      DateTime serviceDate = DateTime.parse(
          '${data[i].getElementValue(data[i].serviceDate)} ${data[i].getElementValue(data[i].serviceTime)}');
      if (currentNow.isBefore(serviceDate)) {
        enrollment.events?.add(data[i]);
        notifyListeners();
      } else {
        enrollmentHistory.events?.add(data[i]);
        notifyListeners();
      }
    }
    notifyListeners();
  }
}
