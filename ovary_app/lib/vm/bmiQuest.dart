import 'package:flutter/material.dart';

class BmiQuestProvider extends ChangeNotifier {
  int height = 0;
  int weight = 0;

  double bmi = 0;
  String result = '';

  String get getResult => result;
  double get getBmi => bmi;

  bmiCalc() {
    bmi = weight / ((height * 0.01) * (height * 0.01));

    if(bmi >= 35){
      result = '귀하의 bmi지수는 ${bmi.toStringAsFixed(2)}이고 고도비만 입니다.';
    } else if(bmi >= 30) {
      result = '귀하의 bmi지수는 ${bmi.toStringAsFixed(2)}이고 2단계 비만 입니다.';
    } else if(bmi >= 25) {
      result = '귀하의 bmi지수는 ${bmi.toStringAsFixed(2)}이고 1단계 비만 입니다.';
    } else if(bmi >= 23) {
      result = '귀하의 bmi지수는 ${bmi.toStringAsFixed(2)}이고 과체중 입니다.';
    } else if(bmi >= 18.5) {
      result = '귀하의 bmi지수는 ${bmi.toStringAsFixed(2)}이고 표준 입니다.';
    } else {
      result = '귀하의 bmi지수는 ${bmi.toStringAsFixed(2)}이고 저체중 입니다.';
    }
    notifyListeners();
  }

}