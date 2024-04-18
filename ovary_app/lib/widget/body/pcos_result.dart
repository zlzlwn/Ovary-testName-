import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovary_app/vm/vm_pcos.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

class PcosResult extends StatelessWidget {
  const PcosResult({super.key});

  @override
  Widget build(BuildContext context) {

    // ignore: unused_local_variable
    final ChangeSwitch controller = Get.put(ChangeSwitch());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PCOS 진단 예측결과',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: IconButton(
            onPressed: () {
              Get.back();
              Get.back();
              Get.back();
              Get.back();
              Get.back();
            },
            icon: const Icon(Icons.home),
          ),
        ),
      ),
      body: Center(child: GetBuilder<ChangeSwitch>(
        builder: (controller) {
          return controller.result == ''
          ? const Center(child: CircularProgressIndicator(),)
          : Center(
            child: Column(
              children: [
                
                //speend meter chart
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: SizedBox(
                    width: 380,
                    child: SpeedometerChart(
                      value: controller.result,
                      graphColor: const [Color.fromARGB(255, 68, 243, 255), Color.fromARGB(255, 255, 64, 64)],
                      maxValue: 100,
                      minValue: 0,
                    ),
                  ),
                ),

                //결과 문구 
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Text(
                    '다낭성 난소 증후군\n'
                    '발생률 ${controller.result.toStringAsFixed(2)}%로 ${controller.strResult}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                //병원찾기
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      ////////////////////*********
                      ///
                      /// 병원찾기 페이지 연결해야함
                      ///
                      ///** */
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(120, 50),
                        backgroundColor:
                            Theme.of(context).colorScheme.primary),
                    child: Text(
                      '병원찾기',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),


              ],
            ),
          );
        },
      ),),
    );
  }
}
