import 'package:flutter/material.dart';

class VmPCOS extends ChangeNotifier {

  bool weightValue = false;

  changeWeightValue() {
    weightValue
    ? weightValue = true
    : weightValue = false;

    notifyListeners();
  }
}