import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/widget/appbar/pcos_title.dart';
import 'package:ovary_app/widget/body/pcos_survey_hair.dart';

class PcosSurveyWeight extends StatelessWidget {
  const PcosSurveyWeight({super.key});

  @override
  Widget build(BuildContext context) {
    PcosTitle();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text('설문'),
            Text('1/4'),
            ElevatedButton(
              onPressed: () => Get.back(), 
              child: Text('이전')
            ),
            ElevatedButton(
              onPressed: () => Get.to(PcosSurveyHair()), 
              child: Text('다음')
            ),
        ],
      ),
    );
  }
}