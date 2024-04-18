import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/widget/body/pcos_survey_acne.dart';

class PcosSurveyHair extends StatelessWidget {
  const PcosSurveyHair({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PCOS 설문',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text('설문'),
            Text('2/4'),
            ElevatedButton(
              onPressed: () => Get.back(), 
              child: Text('이전')
            ),
            ElevatedButton(
              onPressed: () => Get.to(PcosSurveyAcne()), 
              child: Text('다음')
            ),
        ],
      ),
    );
  }
}