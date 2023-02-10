import 'package:flutter/material.dart';

class BaseEntities extends ChangeNotifier {
  bool loading = false;
  bool success = false;
  int page = 1;
  int limit = 10;
  String search = "";
}
