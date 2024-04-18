import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/vm/bmiQuest.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

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

    hValue = box.read('hValue');
    wValue = box.read('wValue');

    bmi.height = hValue;
    bmi.weight = wValue;

    bmi.bmiCalc();
    box.erase();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: SizedBox(
            width: 400,
            child: SpeedometerChart(
              value: bmi.bmi,
              graphColor: const [Color.fromARGB(255, 68, 243, 255), Color.fromARGB(255, 255, 64, 64)],
              maxValue: 40,
              minValue: 0,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Text(
            bmi.result,
            style: const TextStyle(
              fontSize: 20
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
          child: ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back();
              Get.back();
            }, 
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(120, 50),
              backgroundColor: Theme.of(context).colorScheme.primary
            ),
            child: Text(
              '홈으로',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          ),
        )
      ],
    );  
  }
}