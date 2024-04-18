import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovary_app/vm/vm_pcos.dart';
import 'package:ovary_app/widget/body/pcos_survey_hair.dart';

class PcosSurveyWeight extends StatelessWidget {
  const PcosSurveyWeight({super.key});

  @override
  Widget build(BuildContext context) {
    var model = VmPCOS();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PCOS 설문',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
        
              //1/4
              const Padding(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Text(
                '1/4',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),


              //이미지
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Image.asset(
                  'images/fat.png',
                  width: 200,
                ),
              ),

               // 안내 text
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Text(
                  '요즘들어 체중이 증가했나요?',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Switch(
                value: model.weightValue, 
                onChanged: (value) {
                  model.changeWeightValue();
                  model.weightValue = value;
                  

                  print('value ; $value');
                },
              ),

              //버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 10, 0),
                    child: ElevatedButton(
                      onPressed: () => Get.back(), 
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(120, 50),
                        backgroundColor: Theme.of(context).colorScheme.primary
                      ),
                      child: Text(
                        '이전',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
                    child: ElevatedButton(
                      onPressed: () => Get.to(PcosSurveyHair()), 
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(120, 50),
                        backgroundColor: Theme.of(context).colorScheme.primary
                      ),
                      child: Text(
                        '다음',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}