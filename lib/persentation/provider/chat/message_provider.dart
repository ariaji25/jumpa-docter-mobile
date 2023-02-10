import 'package:flutter/material.dart';
import '../../../common/utils/state_enum.dart';

class MessageProvider extends ChangeNotifier {
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;
  
  void setState(RequestState newState) {
    _state = newState;
    notifyListeners();
  }
}