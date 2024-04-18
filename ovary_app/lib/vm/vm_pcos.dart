
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChangeSwitch extends GetxController {
  
  bool weightValue = false;
  bool hairValue = false;
  bool acneValue = false;
  bool skinValue = false;

  int wValue = 0;
  int hValue = 0;
  int aValue = 0;
  int sValue = 0;

  double result = 0;
  String strResult = '';

  //몸무게 switch value 바꾸기
  changeWeightValue() {
    weightValue ?
    weightValue = true :
    weightValue = false;

    update();
  }

  //다모증 switch value 바꾸기  
  changeHairValue() {
    hairValue ?
    hairValue = true :
    hairValue = false;
    
    update();
  }

  //여드름 switch value 바꾸기
  changeAcneValue() {
    acneValue ?
    acneValue = true :
    acneValue = false;
    
    update();
  }

  //다크닝 switch value 바꾸기
  changeSkinValue() {
    skinValue ?
    skinValue = true :
    skinValue = false;
    
    update();
  }

  // 설문조사한 값들로 발생률 가져오기 
  getJSONData() async {

    weightValue ? wValue = 1 : wValue = 0;
    hairValue ? hValue = 1 : hValue = 0;
    acneValue ? aValue = 1 : aValue = 0;
    skinValue ? sValue = 1 : sValue = 0;

    print(wValue);
    print(hValue);
    print(aValue);
    print(sValue);

    var url = Uri.parse('http://localhost:8080/Flutter/Pserve/pcosPred.jsp?weight=$wValue&hair=$hValue&acne=$aValue&dark=$sValue');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(response.body);

    result = dataConvertedJSON['result'] * 100;

    resultText();
    update();
  }

  //결과값을 문자로 
  resultText() {
    if(result <= 20){
      strResult = '매우 안전합니다.';
    } else if (result >=21 && result <= 40) {
      strResult = '안전합니다.';
    } else if (result >=41 && result <= 60) {
      strResult = '보통입니다.';
    } else if (result >=61 && result <= 80) {
      strResult = '다소 위험합니다. \n검사를 받아보는 것이 좋을 것 같습니다.';
    } else {
      strResult = '매우 위험합니다. \n병원에 가는 것을 추천드립니다.';
    }  

    update();
  }

}