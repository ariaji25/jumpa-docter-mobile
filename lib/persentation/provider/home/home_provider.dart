import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int selectedIndexTagArticle = 0;

  int get getSelectedIndexTagArticle => selectedIndexTagArticle;

  setSelectedIndexTagArticle(int value) {
    selectedIndexTagArticle = value;
    notifyListeners();
  }
}
