// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';

enum TypeMessage { FILE, TEXT, IMAGE }

class ChatRoomProvider extends ChangeNotifier {
  final messageController = TextEditingController();
  final controllerCD = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch +
          const Duration(minutes: 1).inMilliseconds);

  int second = 0;
  Duration duration = const Duration(minutes: 30);
  String runningTime = "";
  bool warningEndTime = false;
  bool endTime = false;

  void setRunningTime(value) {
    runningTime = value;
    notifyListeners();
  }

  void setWarningEndTime(value) {
    warningEndTime = value;
    notifyListeners();
  }

  void setEndTime(value) {
    endTime = value;
    notifyListeners();
  }

  void setSecond(value) {
    second = value;
    notifyListeners();
  }
}
