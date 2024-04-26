import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovary_app/view/hospital_map.dart';
import 'package:ovary_app/vm/vm_pcos.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PcosResult extends StatelessWidget {
  const PcosResult({super.key});

  @override
  Widget build(BuildContext context) {

    // ignore: unused_local_variable
    final ChangeSwitch controller = Get.put(ChangeSwitch());
    double checkValue = 0;
    double cValue = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PCOS 진단 예측결과',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple[100],
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

          checkValue = double.parse(controller.result.toStringAsFixed(2)) * 0.01;
          cValue = double.parse(controller.result.toStringAsFixed(2));

          return controller.result == ''
          ? const Center(child: CircularProgressIndicator(),)
          : Center(
            child: Column(
              children: [

                //percentage bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                  child: CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 30.0, // 굵기
                    animation: true,
                    percent: checkValue,
                    footer: const Text(
                      "PCOS 예측 결과",
                    ),
                    circularStrokeCap:
                    CircularStrokeCap.round, // 프로그래스 끝 부분 둥글게
                    progressColor: 
                      cValue >= 80 ? Colors.red
                      : cValue >= 60 ? Colors.orange
                      : cValue >= 40 ? Colors.yellow[600] 
                      : cValue >= 20 ? Colors.blue[300] : Colors.green[300]
                  ),
                ),


                //결과 문구 
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                  child: Text(
                    '다낭성 난소 증후군 진단 결과\n'
                    ' ${controller.textResult} ',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),


                //이전 가기
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: ElevatedButton(
                          onPressed: () { 
                            Get.back();
                            Get.back();
                            Get.back();
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(120, 50),
                              backgroundColor:
                                  const Color(0xff8b7ff5)),
                          child: Text(
                            '다시 진단',
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                            Get.back();
                            Get.back();
                            Get.back();
                            Get.back();
                            Get.to(const HospitalMap());
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(120, 50),
                              backgroundColor:
                                  const Color(0xff8b7ff5)),
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
                ),
              ],
            ),
          );
        },
      ),),
    );
  }
}
