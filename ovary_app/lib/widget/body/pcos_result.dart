import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class PcosResult extends StatelessWidget {
  const PcosResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PCOS 예측 진단',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('진단결과 ~~~~~~~'),
            ElevatedButton(
              onPressed: () {
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                Get.back();
              }, 
              child: Text('홈으로')
            ),
          ],
        ),
        
      ),
    );
  }
}