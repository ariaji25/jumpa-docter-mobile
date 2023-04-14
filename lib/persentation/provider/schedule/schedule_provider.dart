import 'package:flutter/material.dart';
import 'package:jd_mobile/common/extensions/entities_ext.dart';
import 'package:jd_mobile/domain/entities/patient/enrollment_entities.dart';
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
  });

  GetEnrollments getEnrollments;
  GetHistoryEnrollments getHistoryEnrollments;
  GetDetailEnrollment getDetailEnrollment;
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

  Future<void> getEnrollmentDetail(String eventId) async {
    setRequestStateDetailEnrollment(RequestState.Loading);
    final result = await getDetailEnrollment(eventId);
    result.fold((l) {
      setRequestStateDetailEnrollment(RequestState.Error);
      setErrorMessage(l.message);
    }, (r) async {
      detailEnrollment.events = [];
      detailEnrollment.events = r;
      notifyListeners();
      setRequestStateDetailEnrollment(RequestState.Loaded);
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
