// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
enum TypeMessage { FILE, TEXT, IMAGE }

class ChatRoomViewModel extends ChangeNotifier {
  final messageController = TextEditingController();
  final controllerCD = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch +
          const Duration(minutes: 1).inMilliseconds);

  int second = 0;
  Duration duration = const Duration(minutes: 30);
  String runningTime = "";
  bool warningEndTime = false;
  bool endTime = false;
}
