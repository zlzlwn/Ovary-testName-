import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/widget/body/pcos_result.dart';

class PcosSurveySkinDark extends StatelessWidget {
  const PcosSurveySkinDark({super.key});

  @override
  Widget build(BuildContext context) {
    //PcosTitle();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text('설문'),
            Text('4/4'),
            ElevatedButton(
              onPressed: () => Get.back(), 
              child: Text('이전')
            ),
            ElevatedButton(
              onPressed: () => Get.to(PcosResult()), 
              child: Text('다음')
            ),
        ],
      ),
    );
  }
}