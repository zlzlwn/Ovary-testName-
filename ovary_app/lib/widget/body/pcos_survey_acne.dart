import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovary_app/vm/vm_pcos.dart';
import 'package:ovary_app/widget/body/pcos_survey_skindark.dart';

class PcosSurveyAcne extends StatelessWidget {
  const PcosSurveyAcne({super.key});

  @override
  Widget build(BuildContext context) {

    // ignore: unused_local_variable
    final ChangeSwitch controller = Get.put(ChangeSwitch());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PCOS 설문',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: 
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: IconButton(
            onPressed: () {
              Get.back();
              Get.back();
              Get.back();
            },
            icon: const Icon(Icons.home)
          ),
        )
      ),
      body: Center(child: GetBuilder<ChangeSwitch>(
        builder: (controller) {
          return Column(
            children: [
              //3/4
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Text(
                  '3/4',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),

              //이미지
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Image.asset(
                  'images/acne.png',
                  width: 200,
                ),
              ),

              // 안내 text
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Text(
                  '여드름이 눈에 띄게 많이 나나요?',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '아니요',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Switch(
                      value: controller.acneValue,
                      onChanged: (value) {
                        controller.acneValue = value;
                        controller.changeAcneValue();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '네',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              //버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 100, 10, 0),
                    child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(120, 50),
                            backgroundColor:  const Color(0xff8b7ff5),
                        ),   
                        child: Text(
                          '이전',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 100, 0, 0),
                    child: ElevatedButton(
                        onPressed: () => Get.to(const PcosSurveySkinDark()),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(120, 50),
                            backgroundColor:const Color(0xff8b7ff5)),
                        child: Text(
                          '다음',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )),
                  ),
                ],
              )
            ],
          );
        },
      ),),
    );
  }
}
