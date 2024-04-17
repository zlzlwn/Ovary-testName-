import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/vm/bmiQuest.dart';

// ignore: must_be_immutable
class BmiResult extends StatelessWidget {

  var bmi = BmiQuestProvider();

  BmiResult({super.key});

  final box = GetStorage();
  int hValue = 0;
  int wValue = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI 결과',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Center(
          child : calcBMI(context),
      ),
    );
  }

  Widget calcBMI(context) {

    bmi.height = box.read('hValue');
    bmi.weight = box.read('wValue');

    bmi.bmiCalc();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(bmi.getResult),
      ],
    );  
  }
}