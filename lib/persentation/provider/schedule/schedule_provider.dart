import 'package:flutter/material.dart';
import 'package:jd_mobile/domain/entities/patient/enrollment_entities.dart';
import 'package:jd_mobile/domain/usecases/schedule/get_enrollments.dart';
import 'package:jd_mobile/domain/usecases/schedule/get_history_enrollments.dart';

import '../../../common/utils/state_enum.dart';

class ScheduleProvider extends ChangeNotifier {
  ScheduleProvider({
    required this.getEnrollments,
    required this.getHistoryEnrollments,
  });

  GetEnrollments getEnrollments;
  GetHistoryEnrollments getHistoryEnrollments;
  var enrollment = EnrollmentEntities();
  var enrollmentHistory = EnrollmentEntities();
  String _errorMessage = "";
  RequestState _requestState = RequestState.Loading;

  RequestState get requestState => _requestState;

  String get errorMessage => _errorMessage;

  void setRequestState(RequestState state) {
    _requestState = state;
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
      enrollment.events = r;
      notifyListeners();
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
}
